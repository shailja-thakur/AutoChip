module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q, state;

always @(posedge clk) begin
    state <= a & ~b;
end

always @(posedge clk) begin
    if (state) begin
        q <= b;
    end
    else begin
        q <= 0;
    end
end

endmodule
