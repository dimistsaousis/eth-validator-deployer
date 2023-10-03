#!/bin/bash
openssl rand -hex 32 | tr -d "\n" | sudo tee /secrets/jwtsecret

