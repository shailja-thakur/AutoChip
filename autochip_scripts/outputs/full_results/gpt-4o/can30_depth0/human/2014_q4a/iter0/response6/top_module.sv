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
        Q <= R; // Load value R into Q when L is asserted
    end else if (E) begin
        Q <= w; // Shift the input w into Q when E is enabled
    end
    // If neither L nor E is asserted, Q retains its value
end

endmodule
