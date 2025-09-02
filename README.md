# exomiser
Exomiser(v14.1.0)を簡潔に使用するためのスクリプトです。導入済みの場合は3．から参照下さい。<br>
Genomic data soucesはv2502を使用しています。<br>
WSLまたはUbuntuでの実行を想定しています。<br>

<b>1．Exomiser(v14.1.0)の実行環境の準備</b>

java17をインストールします
<pre><code class="language-bash">
conda install -c conda-forge openjdk=17
</code></pre>

任意のディレクトリでExomiserをダウンロードする。
<pre><code class="language-bash">
wget https://github.com/exomiser/Exomiser/releases/download/14.1.0/exomiser-cli-14.1.0-distribution.zip
unzip exomiser-cli-14.1.0-distribution.zip
cd exomiser-cli-14.1.0
mkdir data
</code></pre>

exomiser-cli-14.1.0/dataに配布データ(2502_hg19.zip, 2502_hg38.zip, 2502_phenotype.zip)をダウンロードする。

※ファイル容量が大きいので時間を要する<br>
※<a href="https://github.com/exomiser/Exomiser/discussions" target="_blank">こちら</a>を確認すると最新のバージョンが分かります。<br>
※CLIで取得が難しそうなので、手動でダウンロードして/dataに格納してください。<br><br>
/data内でまとめて解凍します。
<pre><code class="language-bash">
cd data  
ls *.zip | xargs -n1 unzip
</code></pre>

exomiser-cli-14.1.0/application.propertiesの該当箇所を編集します。
LoggingのERROR末尾に数字が入っているとエラーになることがあるので入力されている場合は削除しておきます。
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
･･･
### Logging ###
logging.level.com.zaxxer.hikari=ERROR
</code></pre>

<b>2．テスト解析</b>
