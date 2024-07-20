module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
    // Use a state-transition logic based on inputs a and b.
    if (a && b) begin
        state <= ~state;
    end else if (a) begin
        state <= 1'b0;
    end else if (b) begin
        state <= state;
    end else begin
        state <= 1'b0;
    end

    // Output q is the same as the state.
    q <= state;
end

endmodule
