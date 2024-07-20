module top_module (
	input a,
	input b,
	input sel,
	output out
);

  reg out;

  always @(a, b, sel) begin
    case (sel)
      0: out = a;
      1: out = b;
    endcase
  end

endmodule
