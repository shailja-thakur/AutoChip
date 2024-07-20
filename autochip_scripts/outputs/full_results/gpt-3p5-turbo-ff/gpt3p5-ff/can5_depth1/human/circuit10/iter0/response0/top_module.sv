module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

// Flip-flop implementation
always @(posedge clk) begin
    if (state == 1'b0) begin
        q <= a & b;
        state <= a | b;
    end else begin
        q <= 1'b0;
        state <= 1'b0;
    end
end

endmodule
