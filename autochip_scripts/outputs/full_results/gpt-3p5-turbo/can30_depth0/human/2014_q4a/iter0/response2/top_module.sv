module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

  wire Q_t;
  wire mux_out;

  // D Flip-flop
  always @(posedge clk)
  begin
    if (L)
      Q <= R;
    else if (E)
      Q <= Q_t;
  end

  // 2:1 Mux
  assign mux_out = E ? Q_t : w;

  // D Flip-flop input
  always @(posedge clk)
  begin
    Q_t <= mux_out;
  end

endmodule
