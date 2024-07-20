module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);
	
	reg [1:0] state;
	
	always @(posedge clk) begin
		if (reset)
			state <= BYTE1;
		else begin
			case (state)
				BYTE1:
					if (in[2] == 1'b1)
						state <= BYTE2;
					else
						state <= BYTE1;
				BYTE2:
					if (in[2] == 1'b1)
						state <= BYTE3;
					else
						state <= BYTE1;
				BYTE3:
					if (in[2] == 1'b1)
						state <= DONE;
					else
						state <= BYTE1;
				DONE:
					if (in[2] == 1'b1)
						state <= DONE;
					else
						state <= BYTE1;
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset)
			out_bytes <= 24'b0;
		else begin
			case (state)
				BYTE1:
					out_bytes <= {out_bytes[23:8], in};
				BYTE2:
					out_bytes <= {out_bytes[23:8], in};
				BYTE3:
					out_bytes <= {out_bytes[23:8], in};
				DONE:
					out_bytes <= out_bytes;
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset)
			done <= 1'b0;
		else begin
			if (state == DONE)
				done <= 1'b1;
			else
				done <= 1'b0;
		end
	end
	
endmodule
