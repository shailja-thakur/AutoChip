module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);
	// 8-bit register
	reg [7:0] q;
	
	// Shift in the S input when enable is high
	always @(posedge clk) begin
		if (enable) begin
			q <= {q[6:0], S};
		end
	end
	
	// 3-bit address for multiplexer
	wire [2:0] addr;
	assign addr = {A, B, C};
	
	// Multiplexer to select the output bit
	always @(*) begin
		case (addr)
			3'b000: Z = q[0];
			3'b001: Z = q[1];
			3'b010: Z = q[2];
			3'b011: Z = q[3];
			3'b100: Z = q[4];
			3'b101: Z = q[5];
			3'b110: Z = q[6];
			3'b111: Z = q[7];
			default: Z = 1'b0; // Default case to cover all possible states
		endcase
	end
	
endmodule
