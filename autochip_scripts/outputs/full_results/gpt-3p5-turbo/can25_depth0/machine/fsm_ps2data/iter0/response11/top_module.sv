module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_bytes_reg;
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= BYTE1;
		else
			case (state)
				BYTE1:
					if (in[2])
						state <= BYTE2;
					else
						state <= BYTE1;
				BYTE2:
					if (in[2])
						state <= BYTE3;
					else
						state <= BYTE1;
				BYTE3:
					state <= DONE;
				DONE:
					if (in[2])
						state <= BYTE1;
					else
						state <= BYTE1;
			endcase
	end

	always @(posedge clk) begin
		if (state == DONE)
			out_bytes_reg <= out_bytes_reg;
		else begin
			out_bytes_reg <= {in, out_bytes_reg[23:8]};
		end
	end

	assign out_bytes = out_bytes_reg;
	assign done = (state == DONE);

endmodule
