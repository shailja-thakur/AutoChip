module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [1:0] state;
	reg [7:0] byte1, byte2, byte3;

	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00;
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
		end else begin
			case(state)
				2'b00:
					if (in[3] == 1'b1) begin
						state <= 2'b01;
						byte1 <= in;
					end
				2'b01:
					state <= 2'b10;
					byte2 <= in;
				2'b10:
					state <= 2'b11;
					byte3 <= in;
				2'b11:
					state <= 2'b00;
					byte1 <= 8'b0;
					byte2 <= 8'b0;
					byte3 <= 8'b0;
			endcase
		end
	end

	assign out_bytes = {byte1, byte2, byte3};
	assign done = (state == 2'b11);

endmodule
