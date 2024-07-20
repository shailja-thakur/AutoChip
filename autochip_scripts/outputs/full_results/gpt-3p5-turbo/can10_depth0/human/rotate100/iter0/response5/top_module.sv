module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] reg_data;
	reg [99:0] reg_out;

	always @(posedge clk) begin
		if (load) begin
			reg_data <= data;
			reg_out <= data;
		end else if (ena == 2'b01) begin
			reg_data <= {reg_data[98:0], reg_out[99]};
			reg_out <= {reg_out[99], reg_out[99:1]};
		end else if (ena == 2'b10) begin
			reg_data <= {reg_out[0], reg_data[99:1]};
			reg_out <= {reg_out[1:99], reg_out[0]};
		end
	end

	assign q = reg_out;
endmodule
