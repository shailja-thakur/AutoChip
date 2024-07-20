module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= R;       // Load R into Q when Load signal (L) is high
    end else if (E) begin
        Q <= w;       // Shift in w into Q when Enable (E) is high
    end
end

endmodule
