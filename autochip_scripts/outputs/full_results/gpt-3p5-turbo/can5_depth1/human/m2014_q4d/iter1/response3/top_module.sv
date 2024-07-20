module top_module (
	input clk,
	input in,
	output logic out
);

  reg d;
  wire xor_out;
  reg out_delay;
  
  assign xor_out = in ^ out_delay;
  
  always @(posedge clk) begin 
    d <= xor_out;
    out_delay <= d;
  end
  
  assign out = out_delay;
  
endmodule
