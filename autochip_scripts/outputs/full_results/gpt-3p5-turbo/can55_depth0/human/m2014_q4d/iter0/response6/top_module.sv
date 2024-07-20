module top_module (
	input clk,
	input in,
	output logic out
);

  // D flip-flop with positive edge-triggered clock
  logic d;
  always_ff @(posedge clk) begin
    d <= in ^ out;
    out <= d;
  end

endmodule
