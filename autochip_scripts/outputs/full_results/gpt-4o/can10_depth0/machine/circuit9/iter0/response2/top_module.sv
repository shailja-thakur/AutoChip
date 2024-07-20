module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
    if (a)
        q <= 3'b100;          // Set q to 4
    else if (q == 3'b110)
        q <= 3'b000;          // if q is 6, set q to 0
    else
        q <= q + 1'b1;        // otherwise increment q by 1
end

endmodule
