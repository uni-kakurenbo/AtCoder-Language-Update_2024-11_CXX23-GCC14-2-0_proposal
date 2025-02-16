名前が紛らわしいので `install.toml` はすべて `config.toml` として扱っています．

# About

- `dist/`：提出用の `config.toml` があります．色々展開されたファイルたち．
- `src/`：編集用のソースたち．
- `config/`: コンパイルオプション生成用の pkg-config ファイルたち．
- `test/`：テストコードたち．最低限のもののみ．

# Note
`sub-installer/library/` 内のファイル名は，拡張子 `.sh` を除いて `config.toml` の `library` の key に一致させること．`VERSION` にバージョンが自動的に割り当たる．
