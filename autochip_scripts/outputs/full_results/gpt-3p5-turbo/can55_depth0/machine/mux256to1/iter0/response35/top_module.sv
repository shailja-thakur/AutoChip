module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

  wire [7:0] index;
  wire bit_out;
  
  /*Indexing the input vector*/
  assign index = sel;
  

  /*Extracting the corresponding bit from the input vector*/
  assign bit_out = in[index];

  /*Assigning the output to the extracted bit*/
  assign out = bit_out;

endmodule
