module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

	reg [63:0] shifter;

	always @(posedge clk) begin
		if (load) begin
			shifter <= data;
		end else if (ena) begin
			case (amount)
				2'b00: shifter <= {shifter[62:0], shifter[63]};
				2'b01: shifter <= {shifter[55:0], data[63:56]};
				2'b10: shifter <= {shifter[0], shifter[63:1]};
				2'b11: shifter <= {data[7:0], shifter[63:8]};
			endcase
		end
	end

	assign q = shifter;

endmodule
