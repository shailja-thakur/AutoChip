module top_module (
	input clk,
	input x,
	output z
);

  reg d1, d2, d3;  // D flip-flops
  wire q1, q2, q3; // Flip-flop outputs
  
  xor gate1 (x, q1); // XOR gate
  and gate2 (x, ~q2); // AND gate
  or gate3 (x, ~q3); // OR gate

  always @(posedge clk) begin
    d1 <= q1; // D flip-flop 1
    d2 <= ~q2; // D flip-flop 2
    d3 <= ~q3; // D flip-flop 3
  end

  xnor gate4 (q1, q2, q3, z); // XNOR gate

endmodule
