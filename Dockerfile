# Stage 1: Build the Rust application
FROM rust:1.81-alpine AS builder

# In alpine, it does use musl libc⁠ instead of glibc and friends⁠
RUN apk add --no-cache musl-dev

# Set the working directory inside the container
WORKDIR /usr/src/default_rust_hello_world

# Copy the source code into the container
COPY . .

# Build the Rust project in release mode
RUN cargo build --release

# Stage 2: Create a lightweight Alpine image to run the application
FROM alpine:latest

# Copy the compiled binary from the builder stage
COPY --from=builder /usr/src/default_rust_hello_world/target/release/default_rust_hello_world /usr/local/bin/

# Define the default command to run the binary
CMD ["default_rust_hello_world"]
