module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
  reg w_reg; // shift register input
  
  // Flip-flop
  always @(posedge clk) begin
    if (E) begin
      if (L) begin
        w_reg <= R; // load value from input R
      end else begin
        w_reg <= w_reg; // maintain current value
      end
    end else begin
      w_reg <= w_reg; // maintain current value
    end
  end
  
  // Mux
  always @* begin
    if (E) begin
      if (L) begin
        Q <= R; // output loaded value
      end else begin
        Q <= w_reg; // output shift register value
      end
    end else begin
      Q <= Q; // maintain current value
    end
  end
  
endmodule
