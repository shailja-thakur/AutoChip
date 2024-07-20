module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

always @(posedge clk) begin
    if (a & b) begin
        q <= 1'b1;
        state <= 1'b1;
    end else if (a | b) begin
        q <= 1'b1;
        state <= 1'b0;
    end else begin
        q <= 1'b0;
        state <= 1'b0;
    end
end

endmodule
