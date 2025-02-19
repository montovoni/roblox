@echo off
python -c "import requests" 2>nul || (
    echo Instalando dependências...
    python -m pip install requests
)
