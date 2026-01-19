# Stage 1: Builder avec venv
FROM python:3.11-slim AS builder

# Création du virtualenv
RUN python -m venv /opt/venv

# Activation du venv pour les commandes suivantes
ENV PATH="/opt/venv/bin:$PATH"

# Copie des dépendances locales ET du requirements
COPY dist /build/dist
COPY requirements.txt /build/

WORKDIR /build

# Installation avec find-links pointant vers le répertoire local
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    -r requirements.txt

# Stage 2: Runtime distroless
FROM gcr.io/distroless/python3

# Copie du virtualenv complet depuis le builder
COPY --from=builder /opt/venv /opt/venv

# Activation du venv (aucun sh dans distroless, on utilise PATH)
ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONPATH="/opt/venv/lib/python3.11/site-packages" \
    PYTHONUNBUFFERED=1

# Répertoire de travail
WORKDIR /deploy

# Point d'entrée
ENTRYPOINT ["python3", "-m", "robot"]
CMD ["--version"]