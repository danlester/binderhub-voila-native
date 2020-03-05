FROM python:3.7
RUN pip3 install \
    jhsingle-native-proxy>=0.0.10 \
    voila \
    ipywidgets numpy matplotlib

# create a user, since we don't want to run as root
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

COPY --chown=jovyan:jovyan entrypoint.sh /home/jovyan
COPY --chown=jovyan:jovyan Presentation.ipynb /home/jovyan

EXPOSE 8888

ENTRYPOINT ["/home/jovyan/entrypoint.sh"]

CMD ["jhsingle-native-proxy", "--destport", "8505", "voila", "/home/jovyan/Presentation.ipynb", "{--}port={port}", "{--}no-browser", "{--}Voila.base_url={base_url}/", "{--}Voila.server_url=/"]

