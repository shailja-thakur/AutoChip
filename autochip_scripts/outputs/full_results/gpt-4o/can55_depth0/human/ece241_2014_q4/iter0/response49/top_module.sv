module top_module (
	input clk,
	input x,
	output z
);

  // D flip-flops
  reg Q1, Q2, Q3;

  // Combinational logic for D flip-flop inputs
  wire D1, D2, D3;

  assign D1 = x ^ Q1;
  assign D2 = x & ~Q2;
  assign D3 = x | ~Q3;

  // Flip-flops triggered on the positive edge of the clock
  always @(posedge clk) begin
    Q1 <= D1;
    Q2 <= D2;
    Q3 <= D3;
  end

  // Output Z from the three-input XNOR gate
  assign z = ~(Q1 ^ Q2 ^ Q3);

endmodule
