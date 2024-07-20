module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [23:0] out_reg;
	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= BYTE1;
		else begin
			case (state)
				BYTE1:
					if (in[2] == 1)
						state <= BYTE2;
					else
						state <= BYTE1;
				BYTE2:
					if (in[2] == 1)
						state <= BYTE3;
					else
						state <= BYTE1;
				BYTE3:
					if (in[2] == 1)
						state <= DONE;
					else
						state <= BYTE1;
				DONE:
					if (in[2] == 0)
						state <= BYTE1;
			endcase
		end
	end

	always @(posedge clk) begin
		if (done)
			out_bytes <= out_reg;
		 out_reg <= {in, out_reg[23:8]};
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			done <= 0;
		else begin
			case (state)
				DONE:
					done <= 1;
				default:
					done <= 0;
			endcase
		end
	end

endmodule
