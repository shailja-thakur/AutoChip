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
		state <= BYTE1;
		out_bytes <= 0;
		done <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (in[2] == 1'b1) begin
					state <= BYTE2;
					out_bytes <= {in, out_bytes[23:8]};
				end else begin
					state <= BYTE1;
					out_bytes <= {out_bytes[22:0], in};
				end
			end
			BYTE2: begin
				if (in[2] == 1'b1) begin
					state <= BYTE3;
					out_bytes <= {in, out_bytes[23:8]};
				end else begin
					state <= BYTE1;
					out_bytes <= {out_bytes[22:0], in};
				end
			end
			BYTE3: begin
				if (in[2] == 1'b1) begin
					state <= DONE;
					out_bytes <= {in, out_bytes[23:8]};
				end else begin
					state <= BYTE1;
					out_bytes <= {out_bytes[22:0], in};
				end
			end
			DONE: begin
				if (in[2] == 1'b1) begin
					state <= DONE;
					out_bytes <= {in, out_bytes[23:8]};
				end else begin
					state <= BYTE1;
					out_bytes <= {out_bytes[22:0], in};
				end
			end
		endcase
	end
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		done <= 0;
	end else begin
		if (state == DONE) begin
			done <= 1;
		end else begin
			done <= 0;
		end
	end
end

endmodule
