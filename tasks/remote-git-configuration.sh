echo "📦 Configuring git user"

echo "[user]" > $HOME/.gitconfig
echo "    email = ${GIT_USER_EMAIL}" >> $HOME/.gitconfig
echo "    name = ${GIT_USER_NAME}" >> $HOME/.gitconfig
echo "[safe]" >> $HOME/.gitconfig
echo "    directory = ${HOME}/${PROJECT_NAME}" >> $HOME/.gitconfig

chmod 644 $HOME/.gitconfig
