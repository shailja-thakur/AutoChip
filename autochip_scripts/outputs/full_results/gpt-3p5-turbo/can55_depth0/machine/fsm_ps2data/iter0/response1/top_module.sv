module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		out_bytes <= 0;
		done <= 0;
	end else begin
		case(state)
			0: begin // BYTE1
				out_bytes <= {out_bytes[22:0], in};
				if (in[2] == 1)
					state <= 1; // BYTE2
				else
					state <= 0;
			end
			
			1: begin // BYTE2
				out_bytes <= {out_bytes[22:0], in};
				if (in[2] == 1)
					state <= 2; // BYTE3
				else
					state <= 0;
			end
			
			2: begin // BYTE3
				out_bytes <= {out_bytes[22:0], in};
				state <= 3; // DONE
			end
			
			3: begin // DONE
				out_bytes <= {out_bytes[22:0], in};
				state <= 0;
				done <= 1;
			end
		endcase
	end
end
endmodule
