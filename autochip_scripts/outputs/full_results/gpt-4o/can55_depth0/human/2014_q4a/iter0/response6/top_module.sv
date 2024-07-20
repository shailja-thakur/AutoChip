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
        Q <= R; // Load R value into Q when L is asserted
    end else if (E) begin
        Q <= w; // Shift w into Q when E is asserted
    end
end

endmodule
