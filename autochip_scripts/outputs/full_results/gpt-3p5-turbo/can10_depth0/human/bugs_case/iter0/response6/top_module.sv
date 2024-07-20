module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);

	always@(code) begin
		case(code)
			8'h45: begin
				out = 4'b0000;
				valid = 1'b1;
			end

			8'h16: begin
				out = 4'b0001;
				valid = 1'b1;
			end

			8'h1e: begin
				out = 4'b0010;
				valid = 1'b1;
			end

			8'h26: begin
				out = 4'b0011;
				valid = 1'b1;
			end

			8'h25: begin
				out = 4'b0100;
				valid = 1'b1;
			end

			8'h2e: begin
				out = 4'b0101;
				valid = 1'b1;
			end

			8'h36: begin
				out = 4'b0110;
				valid = 1'b1;
			end

			8'h3d: begin
				out = 4'b0111;
				valid = 1'b1;
			end

			8'h3e: begin
				out = 4'b1000;
				valid = 1'b1;
			end

			8'h46: begin
				out = 4'b1001;
				valid = 1'b1;
			end

			default: begin
				out = 4'b0000;
				valid = 1'b0;
			end
		endcase
	end

endmodule
