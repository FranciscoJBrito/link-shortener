FROM ruby:3.0-bullseye

# Instalando dependencias
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Agregando usuario developer
RUN useradd -m -s /bin/bash developer

# Creando directorio de trabajo
RUN mkdir -p /usr/src

# Cambiando a directorio de trabajo
WORKDIR /usr/src

# Otorgando permisos al usuario developer
RUN chown -R developer:developer /usr/src
RUN chmod -R 755 /usr/src

# Creando directorio de trabajo
RUN mkdir /usr/src/app

# Otorgando permisos al usuario developer en el directorio de trabajo
RUN chown -R developer:developer /usr/src/app
RUN chmod -R 755 /usr/src/app

# Cambiando a directorio de trabajo
WORKDIR /usr/src/app

# Copiando archivos necesarios
COPY Gemfile ./
COPY Gemfile.lock ./

# Instalando dependencias
RUN bundle install

# Copiando archivos de local a contenedor
COPY . .

# Exponiendo puerto 3000
EXPOSE 3000

ENTRYPOINT [ "./entrypoints/docker-entrypoints.sh" ]

# Otorgando permisos de ejecución al script de entrada
RUN chmod +x entrypoints/docker-entrypoints.sh

# Cambiando a usuario developer al final del Dockerfile
USER developer
