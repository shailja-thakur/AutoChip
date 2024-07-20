module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
    if (a == 1 && b == 1) begin
        state <= q;
        q <= 0;
    end else if (a == 1 && b == 0) begin
        state <= q;
        q <= 1;
    end else if (a == 0 && b == 1) begin
        state <= q;
        q <= 1;
    end else if (a == 0 && b == 0) begin
        state <= q;
        q <= q;
    end
end

endmodule
