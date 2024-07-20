module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] temp_q;
	reg [1:0] temp_ena;

	always @(posedge clk) begin
		temp_ena <= ena;
		if (load) begin
			q <= data;
		end else begin
			case (temp_ena)
				2'b01: q <= {q[0], q[99:1]};
				2'b10: q <= {q[98:0], q[99]};
				default: q <= q;
			endcase
		end
	end

endmodule
