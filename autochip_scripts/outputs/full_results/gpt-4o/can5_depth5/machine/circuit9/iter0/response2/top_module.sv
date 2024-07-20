module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1) begin
        q <= 3'b100; // set q to 4 when a is 1
    end
    else if (q == 3'b110) begin
        q <= 3'b000; // set q to 0 when q is 6 and a is 0
    end
    else begin
        q <= q + 1; // increment q by 1 when a is 0 and q is not 6
    end
end

endmodule
