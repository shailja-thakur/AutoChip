module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y;

	always @(posedge clk) begin
		case ({y, x})
			// 000 | 000, 001 | 0
			3'b000_0: begin
				Y <= 3'b000;
				z <= 1'b0;
			end

			// 001 | 001, 100 | 0
			3'b001_0: begin
				Y <= 3'b001;
				z <= 1'b0;
			end

			// 010 | 010, 001 | 0
			3'b010_0: begin
				Y <= 3'b010;
				z <= 1'b0;
			end

			// 011 | 001, 010 | 1
			3'b011_0: begin
				Y <= 3'b001;
				z <= 1'b1;
			end

			// 100 | 011, 100 | 1
			3'b100_0: begin
				Y <= 3'b011;
				z <= 1'b1;
			end
		endcase
	end

	assign Y0 = Y[0];

endmodule
