module top_module (
	input clk,
	input in,
	output logic out
);

  reg q;
  wire xor_out;

  assign xor_out = in ^ q;
  
  always @(posedge clk) begin 
    q <= xor_out;
    out <= q;
  end
  
endmodule
