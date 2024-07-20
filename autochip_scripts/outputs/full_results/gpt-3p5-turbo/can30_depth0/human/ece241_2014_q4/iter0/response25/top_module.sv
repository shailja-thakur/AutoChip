module top_module (
	input clk,
	input x,
	output z
);

  // Creating 3 D flip-flops
  reg d1, d2, d3;

  // Creating the XOR, AND, and OR gates
  wire y1, y2, y3;
  wire y1_comp, y2_comp, y3_comp;

  // Connecting the gates to the flip-flops
  xor #(.delay(1)) xor_gate (.a(d1), .b(y1), .o(y1));
  and #(.delay(1)) and_gate (.a(d2), .b(y2_comp), .o(y2));
  or #(.delay(1)) or_gate (.a(d3), .b(y3_comp), .o(y3));

  // Connecting the flip-flops to the XNOR gate
  xnor #(.delay(1)) xnor_gate (.a(y1), .b(y2_comp), .c(y3_comp), .z(z));

  // Assigning the input x to the flip-flops
  always @(posedge clk) begin
    d1 <= x;
    d2 <= ~d1;
    d3 <= ~d2;
  end

endmodule
