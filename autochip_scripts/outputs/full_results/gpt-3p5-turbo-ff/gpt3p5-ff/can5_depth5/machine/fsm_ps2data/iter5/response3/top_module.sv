module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [2:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		out_bytes <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin  // BYTE1
				if (in[2] == 1) begin
					state <= 1;  // BYTE2
				end else begin
					state <= 0;  // BYTE1
				end
			end
			1: begin  // BYTE2
				state <= 2;  // BYTE3
			end
			2: begin  // BYTE3
				state <= 3;  // DONE
			end
			3: begin  // DONE
				if (in[2] == 0) begin
					state <= 0;  // BYTE1
				end else begin
					state <= 3;  // DONE
				end
			end
			default: begin
				state <= 0;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == 3) begin
		out_bytes <= in;
	end
end

always @(posedge clk) begin
	if (state == 3) begin
		done <= 1;
	end else begin
		done <= 0;
	end
end

endmodule
