# Use the specified image as the base
FROM python:3.12.0b4-bullseye


RUN apt-get update && apt-get install -y \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --upgrade ansible

# Create a new user 'ab', add to sudo group, and set the password
RUN useradd -ms /bin/bash ab && \
    echo "ab:mypassword" | chpasswd && \
    adduser ab sudo

# Give 'ab' passwordless sudo capabilities
RUN echo "ab ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ab

# Change to the new user
USER ab

# Set the working directory
WORKDIR /home/ab

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]

