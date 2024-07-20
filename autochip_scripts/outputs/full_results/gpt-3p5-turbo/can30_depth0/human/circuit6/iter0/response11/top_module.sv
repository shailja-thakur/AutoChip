module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

always @(a) begin
	if(a==3'b000)
		q=16'd1232;
	else if(a==3'b001)
		q=16'daee0;
	else if(a==3'b010)
		q=16'd27d4;
	else if(a==3'b011)
		q=16'd5a0e;
	else if(a==3'b100)
		q=16'd2066;
	else if(a==3'b101)
		q=16'd64ce;
	else if(a==3'b110)
		q=16'dc526;
	else if(a==3'b111)
		q=16'd2f19;
end

endmodule
