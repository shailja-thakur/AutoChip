module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y;
	
	always @(posedge clk) begin
		case({y, x})
			3'b0000: begin
				Y <= 3'b000;
			end
			3'b0001: begin
				Y <= 3'b001;
			end
			3'b0010: begin
				Y <= 3'b010;
			end
			3'b0011: begin
				Y <= 3'b001;
			end
			3'b0100: begin
				Y <= 3'b011;
			end
			default: begin
				Y <= 3'b000;
			end
		endcase
		
		Y0 <= Y[0];
		
		case(Y)
			3'b000: begin
				z <= 1'b0;
			end
			3'b001: begin
				z <= 1'b0;
			end
			3'b010: begin
				z <= 1'b0;
			end
			3'b011: begin
				z <= 1'b1;
			end
			default: begin
				z <= 1'b1;
			end
		endcase
	end

endmodule
