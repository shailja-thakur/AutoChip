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
    if (state == 1'b0) begin
        if (a == 1'b1 && b == 1'b0)
            q <= 1'b1;
        else if (a == 1'b0 && b == 1'b1)
            q <= 1'b0;
    end
    state <= q;
end

assign state = q;

endmodule
