module top_module (
	input clk,
	input a, 
	output reg q
);

always @(posedge clk) begin
    if (q == 0)
        q <= a;
    else
        q <= q;
end

endmodule
