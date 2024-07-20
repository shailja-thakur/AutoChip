// When the input is 4'h0 then the output is 1'bx.
When the input is 4'h1 then the output is 1'bx.
When the input is 4'h2 then the output is 0.
When the input is 4'h3 then the output is 1'bx.
When the input is 4'h4 then the output is 1.
When the input is 4'h5 then the output is 1'bx.
When the input is 4'h6 then the output is 1.
When the input is 4'h7 then the output is 0.
When the input is 4'h8 then the output is 0.
When the input is 4'h9 then the output is 0.
When the input is 4'ha then the output is 1'bx.
When the input is 4'hb then the output is 1.
When the input is 4'hc then the output is 1.
When the input is 4'hd then the output is 1'bx.
When the input is 4'he then the output is 1.
When the input is 4'hf then the output is 1'bx.


module top_module (
	input [4:1] x,
	output logic f
);
