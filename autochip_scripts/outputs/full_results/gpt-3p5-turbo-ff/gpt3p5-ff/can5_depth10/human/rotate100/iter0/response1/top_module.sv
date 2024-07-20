module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);
	
	reg [99:0] reg_data;
	always @(posedge clk) begin
		if (load) begin
			reg_data <= data;
		end else begin
			case (ena)
				2'b01: reg_data <= {reg_data[0], reg_data[99:1]};
				2'b10: reg_data <= {reg_data[98:0], reg_data[99]};
				default: reg_data <= reg_data;
			endcase
		end
	end
	
	assign q = reg_data;
	
endmodule
