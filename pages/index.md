# AtCoder Language Update &ndash; Nov. 2024 <br /> C++23 (GCC 14.2.0) [proposal]

[![workflows:expand-template](https://github.com/uni-kakurenbo/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/actions/workflows/expand.yml/badge.svg)](https://github.com/uni-kakurenbo/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/actions/workflows/expand.yml)
[![workflows:generate-pages](https://github.com/uni-kakurenbo/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/uni-kakurenbo/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/actions/workflows/gh-pages.yml)
[![workflows:test-on-docker](https://github.com/uni-kakurenbo/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/actions/workflows/test-on-docker.yml/badge.svg)](https://github.com/uni-kakurenbo/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/actions/workflows/test-on-docker.yml)

- [Install script](https://uni-kakurenbo.github.io/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/#install-script)
- [Compile script](https://uni-kakurenbo.github.io/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/#compile-script)
- [Configuration file](https://uni-kakurenbo.github.io/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/#configuration-file)

## [Library](https://github.com/uni-kakurenbo/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/blob/main/src/sub-installers)

### Official
- [AC Library](https://atcoder.github.io/ac-library/master/document_ja/): `1.5.1`
    - The official, original library provided by AtCoder.
    - inherited

### Utility
- [Range-v3](https://ericniebler.github.io/range-v3/): `0.12.0`
    - A predecessor for some features that may be implemented in future C++.
    - proposed at [2024/11/11 23:46](https://discord.com/channels/1245258617582653553/1293457974442070016/1305545161727672350)
    - [「いずれ利用できるようになるので，先取りしておくことに否定的である必要はない」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306609306996707398)
    - [「いずれ C++ 標準入りするなら，早期から使えるようにしたところで長期的には特に問題ない」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)

- [unordered_dense](https://github.com/martinus/unordered_dense): `4.4.0`
    - A densely stored hashmap (and hashset) based on robin-hood hashing and backward shift deletion.
    - proposed at [2024/11/10 07:24](https://discord.com/channels/1245258617582653553/1293457974442070016/1304934690616115251)
    - [「機能面を見るに，C++ 標準 (GNU 拡張含む) や Boost で十分に思える．性能面で優れているところが動機だと思うが，それで外部ライブラリの導入を進めると際限なく広がってしまうので，やはり反対」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)

### Advanced STL-like
- [Abseil](https://abseil.io/docs/cpp/quickstart): `20240722.0`
    - A set of libraries developed by Google to argument C++ Standard Library.
    - proposed at [2024/11/10 08:28](https://discord.com/channels/1245258617582653553/1293457974442070016/1304950777604735097)
    - [「機能面を見るに，C++ 標準 (GNU 拡張含む) や Boost で十分に思える．性能面で優れているところが動機だと思うが，それで外部ライブラリの導入を進めると際限なく広がってしまうので，やはり反対」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)

- [Boost](https://www.boost.org/): `1.86.0`
    - A set of portable, versatile libraries that work well with C++ Standard Library.
    - inherited

### Mathematical
- [Eigen](https://eigen.tuxfamily.org/index.php?title=Main_Page): `3.4.0-4` (apt)
    - A C++ template library for linear algebra.
    - inherited
    - [「機能面を見るに，C++ 標準 (GNU 拡張含む) や Boost で十分に思える．性能面で優れているところが動機だと思うが，それで外部ライブラリの導入を進めると際限なく広がってしまうので，やはり反対」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)

- [GMP](https://gmplib.org/): `2:6.3.0+dfsg-2ubuntu6.1` (apt)
    - The GNU
Multiple Precision
Arithmetic Library
    - inherited

### Machine learning
- [LibTorch](https://pytorch.org/cppdocs/installing.html): `2.5.1`
    - A C++ bindings for [PyTorch](https://pytorch.org/).
    - proposed at [2024/11/10 08:28](https://discord.com/channels/1245258617582653553/1293457974442070016/1304950777604735097)
    - [「過去問は機械学習が本番一位を取った回があり (中略) 普通に使えるチャンスがあるのかも」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306591214392447088)

- [LightGBM](https://lightgbm.readthedocs.io/en/latest/): `4.5.0`
    - A gradient boosting framework that uses tree based learning algorithms.
    - inherited (as a proposal)

#### Comments
- [「AtCoder は今後 Heuristic 系コンテストにも力を入れていくようなので，それに対応して導入するのはアリじゃないか」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)
- [「現状提案されてるのは大体もう Python から使えることを考えると大きな影響はないのでは」](https://discord.com/channels/1245258617582653553/1293457974442070016/1307648262941179924)


### Solver
- [OR-Tools](https://developers.google.com/optimization):`9.11`
    - A portable software designed by Google to solve combinatorial optimization problems.
    - inherited (as a proposal)

- [Z3](https://github.com/Z3Prover/z3): `4.13.3`
    - A theorem prover designed by Microsoft Research to solve satisfiability modulo theories (SMT).
    - inherited (as a proposal)

#### Comments
- [「AHC で活躍する想定だと思うが，アルゴ系コンテストの競技性を損なう可能性がある」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)
- [「現状提案されてるのは大体もう Python から使えることを考えると大きな影響はないのでは」](https://discord.com/channels/1245258617582653553/1293457974442070016/1307648262941179924)


## [Compile flags](https://github.com/uni-kakurenbo/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/blob/main/config)
Some other flags might be appended, depending on libraries that is to be installed; see also [compile script](https://uni-kakurenbo.github.io/AtCoder-Language-Update_2024-11_CXX23-GCC14-2-0_proposal/#compile-script), which appears below.

### Basic
- `-std=gnu++23`

### Environment variable
- `-DONLINE_JUDGE`
- `-DATCODER`

### Warning
- `-Wall`
- `-Wextra`

### Optimization
- `-O2`
- `-O3` (not yet implemented)
    - [「Topcoder で採用例がある」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)

- `-march=native`
    - [「つけたせいで WA になった人がいる」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306599336418738248)
    - [「おそらく (`-O2` を抜いて) 一番定数倍に貢献する」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306602100977045565)
    - [「`pragma` による高速化を知っている人と知らない人で得点に差が出るのは不公平」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306624382331785268)
        - [「`-march=native` を入れても『 `pragma` 文による高速化を知っている人と知らない人で得点に差が出る』と考えられる」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306646900086145094)
        - [「(コンパイラのバグにより)『`-march=native` は `pragma` で代替できる』が偽という可能性」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306654135478648843)
    - [「バグが起きやすくなるという話もあるが，(中略) 競技にはほとんど関係ない確率ではないか」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306624382331785268)
    - [「`#pragma GCC …` で普通に使える」](https://discord.com/channels/1245258617582653553/1293457974442070016/1307648262941179924)
    - [「現環境でバグに出くわす例があって悩ましいが，強い最適化の恩恵にはあずかりたい」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)

- `-flto=auto`
    - [「かつては問題もややあったよう」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306609306996707398)
    - [「GCC 14 時点での安定性については分りかねるが，再度検討して損はない」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306609306996707398)
    - [「詳しく把握しないままに追加すると思わぬトラブルになるかも」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)
    - [「精査が必要だと考え，現時点での追加には反対」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)

#### Comments
- [「他にも潜在的なバグがある可能性はある」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306599336418738248)
- [「万が一バグを引き起こしたらデバッグが困難」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306599336418738248)
- [「Algo だと `-O2` のみでおそらく十分な一方で，Heuristics 観点だとどうなのだろう」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306591214392447088)
    - [「定数倍速い言語枠が Algo ほど C++ 一色ではない = C++ を使う人にとって C++ のみを高速化することに普通にインセンティブがある」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306591214392447088)


### Limit-relaxing
- `-fconstexpr-depth=1024` \
`-fconstexpr-loop-limit=524288` \
`-fconstexpr-ops-limit=67108864`
    - Each value specified is double the default.
    - inherited
    - [「(設定値が大きい場合) 困る例がある」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306625653805682769)
    - [「コンパイル時間が長くなりサーバーが重くなる原因になるので，制限をきつくしてもいい」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306624382331785268)
    - [「コンパイル時計算は遅いとのことで，デフォルトの上限を緩和するのはトラブルの元」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)
    - 備考: かつては設定できる最大値 (`4294967295`) が指定されていた．

### Extra features
- `-lstdc++exp`
    - enables experimental library features
    - [「競プロ (特に Algo) とはほぼ関係ない (導入しても大きな問題はない) のでは」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306609306996707398)
    - [「標準ライブラリにあるのであれば有効にしてもいいのでは」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306624382331785268)
    - [「Codeforces で採用例がある」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)
    - [「`<stacktrace>` ないし `<experimental/filesystem>` を include しない限り等しいバイナリを吐くはず」](https://discord.com/channels/1245258617582653553/1293457974442070016/1317667609176703038)

- `-fopenmp`
    - makes OpenMP available
    - proposed at [2024/11/13 22:17](https://discord.com/channels/1245258617582653553/1293457974442070016/1306246622417780736):
        - [「Heuristic での自由度を高めるために提案したものだが，Algo でなにか不都合があるのだとしたらつけなくてもいい」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306624382331785268)
    - [「`-O2` あたりと違って opt-in (選択的に有効にできる)」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306253046283632642)
    - [「AtCoder 上ではマルチスレッド化が無意味なので `-fopenmp` でもたぶん結果的に同じだが，「simdだけ」を明確化するために `-fopenmp-simd` とした方がよい」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)
    - [「OpenMP の pragma を書く必要がありそうで，標準からの逸脱感は否めない」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)

## Comments
- [「オプションが導入されたときに環境が本当に改善されるのか慎重に考えてほしい」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306580652933644340)
- [「コンテストなどの何らかの活動でオプション追加の恩恵を具体的に受けることはおそらくほぼないので，不安の一方」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306580652933644340)

- [「言語のオプションのレギュレーションが必要かどうかは AtCoder 社が考えることであり，先回り忖度して自粛する必要はない」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306593655439626251)

- [「他のコンテストサイトの環境とかけ離れるのには大きく反対」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306604370422665246)
- [「アルゴリズムコンテストの目的を考えると，なんでもかんでも高速に・便利にすればよいというものではない」]((https://discord.com/channels/1245258617582653553/1293457974442070016/1306604370422665246))
    - [「言語を分離しようが "速いC++" が残ってたら意味がないという意見？」](https://discord.com/channels/1245258617582653553/1293457974442070016/1306658394584645794)

- [「(強力なライブラリやオプションについて) もし悪影響が目立ち始めたら，GPT 同様にその時考えるというスタイルでいいのでは」](https://discord.com/channels/1245258617582653553/1293457974442070016/1307648262941179924)


- [「あくまで C++ 標準の上での勝負だと思っているので，外部ライブラリには基本反対」](https://discord.com/channels/1245258617582653553/1293457974442070016/1308248462772408373)
