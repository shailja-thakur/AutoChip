module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
  reg D;
  
  // Multiplexer
  wire mux_out;
  assign mux_out = E ? w : Q;
  
  // Flip-flop
  always @(posedge clk) begin
    if (L) begin
      D <= R;
    end else if (E) begin
      D <= mux_out;
    end
  end
  
  // Output
  always @(posedge clk) begin
    Q <= D;
  end
endmodule
