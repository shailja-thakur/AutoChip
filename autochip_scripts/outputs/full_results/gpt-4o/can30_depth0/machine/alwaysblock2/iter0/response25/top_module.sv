module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

  // Perform XOR operation and assign directly to out_assign
  assign out_assign = a ^ b;

  // Combinational logic - Always block to update out_always_comb
  always @* begin
    out_always_comb = out_assign;
  end

  // Sequential logic - Always block to update out_always_ff on clock edge
  always @(posedge clk) begin
    out_always_ff = out_assign;
  end

endmodule
