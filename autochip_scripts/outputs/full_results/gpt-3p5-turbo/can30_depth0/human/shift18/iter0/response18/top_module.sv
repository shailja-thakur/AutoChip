module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

	reg [63:0] temp;

	always @(posedge clk) begin
		if (load) begin
			temp <= data;
		end else if (ena) begin
			case(amount)
				2'b00: temp <= {temp[62:0], temp[63]};
				2'b01: temp <= {temp[55:0], temp[63:56]};
				2'b10: temp <= {temp[0], temp[63:1]};
				2'b11: temp <= {temp[7:0], temp[63:8]};
			endcase
		end
	end

	assign q = temp;

endmodule
