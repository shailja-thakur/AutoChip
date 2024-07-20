module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);

// Define constants for the valid codes
parameter [7:0] CODE_0 = 8'h45;
parameter [7:0] CODE_1 = 8'h16;
parameter [7:0] CODE_2 = 8'h1e;
parameter [7:0] CODE_3 = 8'h26;
parameter [7:0] CODE_4 = 8'h25;
parameter [7:0] CODE_5 = 8'h2e;
parameter [7:0] CODE_6 = 8'h36;
parameter [7:0] CODE_7 = 8'h3d;
parameter [7:0] CODE_8 = 8'h3e;
parameter [7:0] CODE_9 = 8'h46;

always @(code) begin
	case(code)
		CODE_0 : begin
			out <= 4'b0000;
			valid <= 1'b1;
		end
		CODE_1 : begin
			out <= 4'b0001;
			valid <= 1'b1;
		end
		CODE_2 : begin
			out <= 4'b0010;
			valid <= 1'b1;
		end
		CODE_3 : begin
			out <= 4'b0011;
			valid <= 1'b1;
		end
		CODE_4 : begin
			out <= 4'b0100;
			valid <= 1'b1;
		end
		CODE_5 : begin
			out <= 4'b0101;
			valid <= 1'b1;
		end
		CODE_6 : begin
			out <= 4'b0110;
			valid <= 1'b1;
		end
		CODE_7 : begin
			out <= 4'b0111;
			valid <= 1'b1;
		end
		CODE_8 : begin
			out <= 4'b1000;
			valid <= 1'b1;
		end
		CODE_9 : begin
			out <= 4'b1001;
			valid <= 1'b1;
		end
		default : begin
			out <= 4'b0000;
			valid <= 1'b0;
		end
	endcase
end

endmodule
