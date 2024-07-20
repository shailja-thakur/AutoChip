module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);
	
	reg [99:0] shift_reg;
	reg [1:0] rotate_dir;
	
	always @(posedge clk) begin
		if (load) begin
			shift_reg <= data;
			rotate_dir <= 2'b00;
		end else begin
			case (ena)
				2'b00: begin
					shift_reg <= shift_reg;
					rotate_dir <= ena;
				end
				2'b01: begin
					shift_reg <= {shift_reg[0], shift_reg[99:1]};
					rotate_dir <= ena;
				end
				2'b10: begin
					shift_reg <= {shift_reg[98:0], shift_reg[99]};
					rotate_dir <= ena;
				end
				default: begin
					shift_reg <= shift_reg;
					rotate_dir <= ena;
				end
			endcase
		end
	end
	
	assign q = shift_reg;
	
endmodule
