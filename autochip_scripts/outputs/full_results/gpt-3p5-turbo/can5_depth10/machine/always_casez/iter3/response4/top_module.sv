module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

// Declare variables for intermediate signals
reg [7:0] temp;

always @* begin
	temp = in[3:0];   // Extract the desired 4 bits from the input
	
	case(temp)
		4'b0001: pos = 3'b000;
		4'b1000: pos = 3'b110;
		default: pos = 3'b000;
	endcase
end

endmodule
