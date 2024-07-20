module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1'b0)
        q <= 3'b0;
    else if (q == 3'b0)
        q <= 3'b1;
    else if (q == 3'b1)
        q <= 3'b0;
    else if (q == 3'b4 && a == 1'b1)
        q <= 3'b5;
    else if (q == 3'b5 && a == 1'b1)
        q <= 3'b6;
    else if (q == 3'b6 && a == 1'b1)
        q <= 3'b0;
end

endmodule
