# ame-ai

いろいろな会社の AI と標準入出力で話す小さなコマンド(MCP のツール呼び出しつき)。

[ame-shell](https://github.com/TatsuyaM2667/ame-shell)(Wayland のデスクトップシェル)の一部を、単独で使えるように切り出したものです。
ame-shell は画面の要らない仕事を、1 つのことをして標準入出力でやりとりする小さなコマンドに分けています。これはその 1 つです。

## 使い方

```text
ame-ai: いろいろな会社の AI と API で話す。

  echo 質問 | ame-ai [-p 会社] [-m モデル] [-s 指示] [-i 画像]…  返事の文章を標準出力へ(届いた分から)
  ame-ai --json [-p …] [-m …] [-s …] [--mcp 名前,名前] < 会話.json  1 行 1 つの出来事(JSON)を標準出力へ
  ame-ai models [-p 会社]                                          その会社のモデルの id を 1 行ずつ
  ame-ai providers                                                 会社の id と名前

会社とモデルを省くと、ame-shell の AI チャットで最後に選んだもの($XDG_STATE_HOME/ame-shell/ai)。
--json の会話の形は lib/ai.zig の parseConversation。出来事は:
  {"type":"status","text":…}                       準備中など
  {"type":"text","text":…} / {"type":"think",…}    返事の文章・考えている途中(少しずつ)
  {"type":"tool_call","id","name","arguments","label"}  モデルが MCP のツールを呼んだ(このあと実行する)
  {"type":"tool_result","id","content","error"}     ツールの結果。このあと、続きの返事が始まる
  {"type":"error","message":…}                      失敗(終了コード 1)
  {"type":"done"}
--mcp で選んだ stdio の MCP サーバを起動し、ツールをモデルに渡す。モデルが呼んだら実行して結果を返し、
続きを答えさせる(12 往復まで)。API キーはコマンドラインに出さず curl の標準入力(-K -)で渡す。
止めるときはプロセスグループごと(curl・MCP サーバも)止める。
```

## ビルド

```sh
zig build -Doptimize=ReleaseSafe   # zig-out/bin/ame-ai(Zig 0.13、libc だけ)
zig build test
```

実行に要るもの: `curl`

## このリポジトリについて

正本は ame-shell の `src/cmd/ame-ai.zig` です。このリポジトリは `scripts/split-repos.sh` が生成して同期しています。
直したいところがあれば ame-shell の方へお願いします。

ライセンス: GPL-3.0(ame-shell と同じ)
