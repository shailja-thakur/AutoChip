module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] lower_byte_reg;
	reg [7:0] upper_byte_reg;

	always @(posedge clk or negedge resetn) begin
		if(!resetn) begin
			lower_byte_reg <= 8'h0;
			upper_byte_reg <= 8'h0;
		end else begin
			if(byteena[0]) lower_byte_reg <= d[7:0];
			if(byteena[1]) upper_byte_reg <= d[15:8];
		end
	end

	always @(posedge clk) begin
		if(!resetn) q <= 16'd0;
		else q <= {upper_byte_reg, lower_byte_reg};
	end

endmodule
