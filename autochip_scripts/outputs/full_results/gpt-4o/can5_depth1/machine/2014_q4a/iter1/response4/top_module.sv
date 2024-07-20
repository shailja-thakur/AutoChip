module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk or posedge R) begin
	if (R)
		Q <= 1'b0;  // Reset condition, force Q to 0
	else if (E) begin
		if (L)
			Q <= R;  // When L is high, Q is updated with the value of R.
		else
			Q <= w;  // When L is low, Q is updated with the value of w.
	end
end

endmodule
