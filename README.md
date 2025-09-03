# exomiser
Exomiser(v14.1.0)を簡潔に使用するためのスクリプトです。導入済みの場合は4．から参照下さい。<br>
Genomic data soucesはv2502を使用しています。<br>
WSLまたはUbuntuでの実行を想定しています。<br>

<b>1．Exomiser(v14.1.0)と配布データのダウンロード</b><br>
任意のディレクトリでExomiserをダウンロードする。
<pre><code class="language-bash">
#!/bin/bash
wget https://github.com/exomiser/Exomiser/releases/download/14.1.0/exomiser-cli-14.1.0-distribution.zip
unzip exomiser-cli-14.1.0-distribution.zip
cd exomiser-cli-14.1.0
mkdir data
</code></pre>

<code>exomiser-cli-14.1.0/data</code>に配布データ(<code>2502_hg19.zip</code>, <code>2502_hg38.zip</code>, <code>2502_phenotype.zip</code>)をダウンロードする。

※ファイル容量が大きいので時間を要する<br>
※<a href="https://github.com/exomiser/Exomiser/discussions" target="_blank">こちら</a>を確認すると最新のバージョンが分かります。<br>
※CLIで取得が難しそうなので、手動でダウンロードして<code>/data</code>に格納してください。<br><br>
<code>/data</code>内でまとめて解凍します。
<pre><code class="language-bash">
#!/bin/bash
cd data  
ls *.zip | xargs -n1 unzip
</code></pre>

<code>exomiser-cli-14.1.0/application.properties</code>の該当箇所を編集します。

<pre><code class="language-bash">
...
### hg 19 assembly ###
exomiser.hg19.data-version=<b>2502</b>
･･･
### hg38 assembly ###
exomiser.hg38.data-version=<b>2502</b>
･･･
### phenotypes ###
exomiser.phenotype.data-version=<b>2502</b>
</code></pre>

<b>2．実行環境の用意</b><br>
conda仮想環境内で実行環境を構築します。condaコマンドを使えない場合は別途取得してください。<br>
<pre><code class="language-bash">
#!/bin/bash
conda create -n exomiser-run bash coreutils gawk sed 
conda activate exomiser-run
conda install -c conda-forge openjdk=17
</code></pre>
念のため、Javaのパスが通っているか確認してください。
<pre><code class="language-bash">
#!/bin/bash
java --version
</code></pre>
<b>3．テスト解析</b><br>
インストールディレクトリ内で以下を実行します。
<pre><code class="language-bash">
#!/bin/bash
java -Xms2g -Xmx4g -jar exomiser-cli-14.1.0.jar --analysis examples/test-analysis-exome.yml
</code></pre>

★エラー対応:application.propertiesファイルの修正<br>
配布データはexomiser-cli-14.1.0/data内を参照してくれるはずですが、うまくいかない場合は以下の通り修正します。
<pre><code class="language-bash">
･･･
## exomiser root data directory ##
exomiser.data-directory=./data
</code></pre>
LoggingのERROR末尾に数字が入っているとエラーになることがあるので入力されている場合は削除しておきます。
<pre><code class="language-bash">
･･･
### Logging ###
logging.level.com.zaxxer.hikari=ERROR
</code></pre>
これでテスト解析がうまくいくはずです。

<b>4. 配布スクリプトの実行手順</b><br>
サンプルごとの<code>.vcf</code>ファイルパス、HPO idを記載した<code>.csv</code>を用意します(<code>example.csv</code>を参考にしてください)<br>
トリオ解析の場合は<code>.bed</code>ファイルパスも入力できますが、単独解析の場合は空欄にしてください。<br>
当リポジトリから<code>script.sh</code>と<code>template.yml</code>をダウンロードしてどちらも<code>exomiser-cli-14.1.0</code>直下に配置してください。
<code>exomiser-cli-14.1.0</code>で以下を実行します。
<pre><code class="language-bash">
#!/bin/bash
bash script.sh yourfile.csv
</code></pre>
<code>exomiser-cli-14.1.0/results</code>に<code>.tsv</code>が生成されます。
細かい調整をしたい場合は<code>template.yml</code>の内容を修正してください。<br>
ワーキングディレクトリを変更したい場合は<code>script.sh</code>内のパスを改変してください。





