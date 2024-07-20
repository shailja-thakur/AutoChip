module top_module (
	input clk,
	input a, 
	output reg q
);

always @(posedge clk) begin
    if (a == 0)
        q <= q;
    else
        q <= ~q;
end

endmodule
