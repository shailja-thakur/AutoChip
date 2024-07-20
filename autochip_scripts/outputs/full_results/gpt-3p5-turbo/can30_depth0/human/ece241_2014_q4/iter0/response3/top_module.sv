module top_module (
	input clk,
	input x,
	output z
);

  reg [2:0] d_flop;
  wire [2:0] d_flipflop_outputs;

  xor #(.N(1)) xor_gate (d_flop[0], d_flipflop_outputs[0], x);
  and #(.N(1)) and_gate (d_flop[1], ~d_flipflop_outputs[1], x);
  or  #(.N(1)) or_gate (d_flop[2], ~d_flipflop_outputs[2], x);

  xnor #(.N(2)) xnor_gate (z, d_flipflop_outputs);

  always @(posedge clk) begin
    d_flop <= d_flipflop_outputs;
  end

endmodule
