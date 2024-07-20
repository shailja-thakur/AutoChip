module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if(a == 1'b1 && q == 3'b100)
		q <= 3'b101;
	else if(a == 1'b0 && q == 3'b101)
		q <= 3'b110;
	else if(a == 1'b0 && q == 3'b110)
		q <= 3'b000;
	else if(a == 1'b0 && q == 3'b000)
		q <= 3'b001;
end

endmodule
