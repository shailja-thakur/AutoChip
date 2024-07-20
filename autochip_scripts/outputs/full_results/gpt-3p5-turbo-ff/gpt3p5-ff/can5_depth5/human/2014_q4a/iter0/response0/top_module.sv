module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
	reg w_next;
	
	always @(posedge clk) begin
		if (E) begin
			w_next <= w;
		end else if (L) begin
			w_next <= R;
		end
	end
	
	always @(posedge clk) begin
		if (L) begin
			Q <= R;
		end else begin
			Q <= w_next;
		end
	end
endmodule
