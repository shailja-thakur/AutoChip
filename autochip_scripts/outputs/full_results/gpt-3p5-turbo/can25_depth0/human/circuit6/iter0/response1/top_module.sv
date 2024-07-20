module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	// Declare a temporary variable
	reg [3:0] temp;

	always @* begin
		// Use a case statement to determine the value of q based on the value of a
		case (a)
			3'b000: temp = 4'b0000;
			3'b001: temp = 4'b0011;
			3'b010: temp = 4'b0101;
			3'b011: temp = 4'b0110;
			3'b100, 3'b101: temp = 4'b1001;
			default: temp = 4'b1111;
		endcase
	
		// Use temp to assign a value to q
		q = {temp, temp};
	end
	
endmodule
