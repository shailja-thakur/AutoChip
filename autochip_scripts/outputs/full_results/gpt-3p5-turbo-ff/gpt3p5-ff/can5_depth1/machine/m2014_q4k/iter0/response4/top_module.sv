module top_module (
	input clk,
	input resetn,
	input in,
	output reg [3:0] out //Changed output declaration to reg
);

reg [3:0] sr; //Declared sr as reg

always @(posedge clk) begin //Added always block
	if (resetn == 0) begin //Added if-else condition
		sr <= 4'b0000; //Reset sr to all zeros
	else
		sr <= {sr[2:0], in}; //Shift left and load input in the least significant bit
	end
end

assign out = sr[3]; //Assign most significant bit of sr to out

endmodule
