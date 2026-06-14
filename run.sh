#!/bin/bash
COMMAND=$1
case "$COMMAND" in
    build_generator)
        docker build -t data-generator -f generator/Dockerfile ./generator
        ;;
    run_generator)
        mkdir -p data
        docker run --rm -v "$(pwd)/data:/data" data-generator python generate.py /data
        ;;
    create_local_data)
        mkdir -p local_data
        python generator/generate.py local_data
        ;;
    build_reporter)
        docker build -t data-reporter -f reporter/Dockerfile ./reporter
        ;;
    run_reporter)
        mkdir -p data
        docker run --rm -v "$(pwd)/data:/data" data-reporter
        ;;
    structure)
        if command -v tree &> /dev/null; then
            tree -I 'node_modules|.git'
        else
            find . -not -path '*/.*' -not -path './node_modules*'
        fi
        ;;
    clear_data)
        rm -f data/*.csv data/*.html
        ;;
    inside_generator)
        docker run --rm -v "$(pwd)/data:/data" data-generator ls -la /data
        ;;
    inside_reporter)
        docker run --rm -v "$(pwd)/data:/data" data-reporter ls -la /data
        ;;
    *)
        echo "Использование: ./run.sh {build_generator|run_generator|create_local_data|build_reporter|run_reporter|structure|clear_data|inside_generator|inside_reporter}"
        exit 1
        ;;
esac