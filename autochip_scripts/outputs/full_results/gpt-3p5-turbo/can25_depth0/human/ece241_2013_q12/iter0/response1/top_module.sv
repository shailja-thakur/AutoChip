module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);
	// Declare flip-flops
	reg [7:0] Q;
	
	// 8-bit Shift Register
	always @(posedge clk) begin
		if (enable) begin
			Q <= {S, Q[7:1]};  // Shift in S to the MSB
		end
	end
	
	// Output multiplexer
	always @(A, B, C, Q) begin
		case ({A, B, C})
			3'b000: Z = Q[0];
			3'b001: Z = Q[1];
			3'b010: Z = Q[2];
			3'b011: Z = Q[3];
			3'b100: Z = Q[4];
			3'b101: Z = Q[5];
			3'b110: Z = Q[6];
			3'b111: Z = Q[7];
		endcase
	end
endmodule
