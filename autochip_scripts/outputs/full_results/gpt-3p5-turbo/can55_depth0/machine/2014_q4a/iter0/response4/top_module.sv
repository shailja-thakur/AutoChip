module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

  always @(posedge clk) begin
    if (L == 1) begin
      Q <= R;
    end else begin
      if (E == 1) begin
        Q <= w;
      end else begin
        Q <= Q;
      end
    end
  end
  
endmodule
