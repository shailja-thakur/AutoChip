module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	
  // Wire declaration
  wire [7:0] index;
  
  // Assigning 'index' wire to select the index from 'in'
  assign index = sel;
  
  // Assigning 'out' wire to select the corresponding bit from 'in'
  assign out = in[index];
  
endmodule
