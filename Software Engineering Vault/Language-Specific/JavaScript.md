#javascript #wasm #web-assembly

### Web assembly (WASM) vs. JavaScript

* For large, CPU-intensive tasks, WASM performs better.
* For smaller scale applications, JavaScript performs better.
    * The reason why is because the WASM module has to be loaded. The process can take up to several seconds.
    * Just like JavaScript, a web assembly VM runs in the browser that executes the WASM modules. The overhead for WASM seems to be higher than JavaScript's.