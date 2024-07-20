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
    if (a == 0 && b == 1)
        state <= 1;
    else if (a == 1 && b == 0)
        state <= 0;
    else if (a == 1 && b == 1)
        state <= 1;
end

always @(posedge clk) begin
    if (state == 1)
        q <= a;
    else
        q <= 0;
end

endmodule
