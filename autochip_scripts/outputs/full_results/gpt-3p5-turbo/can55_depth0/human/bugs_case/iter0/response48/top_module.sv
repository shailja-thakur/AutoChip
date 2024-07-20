module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);

	always @* begin
		case(code)
			8'h45: begin
				out = 4'b0000; // Set output to 0
				valid = 1'b1; // Set valid to 1
			end
			8'h16: begin
				out = 4'b0001; // Set output to 1
				valid = 1'b1; // Set valid to 1
			end
			8'h1e: begin
				out = 4'b0010; // Set output to 2
				valid = 1'b1; // Set valid to 1
			end
			8'h26: begin
				out = 4'b0011; // Set output to 3
				valid = 1'b1; // Set valid to 1
			end
			8'h25: begin
				out = 4'b0100; // Set output to 4
				valid = 1'b1; // Set valid to 1
			end
			8'h2e: begin
				out = 4'b0101; // Set output to 5
				valid = 1'b1; // Set valid to 1
			end
			8'h36: begin
				out = 4'b0110; // Set output to 6
				valid = 1'b1; // Set valid to 1
			end
			8'h3d: begin
				out = 4'b0111; // Set output to 7
				valid = 1'b1; // Set valid to 1
			end
			8'h3e: begin
				out = 4'b1000; // Set output to 8
				valid = 1'b1; // Set valid to 1
			end
			8'h46: begin
				out = 4'b1001; // Set output to 9
				valid = 1'b1; // Set valid to 1
			end
			default: begin
				out = 4'b0000; // Set output to 0
				valid = 1'b0; // Set valid to 0
			end
		endcase
	end

endmodule
