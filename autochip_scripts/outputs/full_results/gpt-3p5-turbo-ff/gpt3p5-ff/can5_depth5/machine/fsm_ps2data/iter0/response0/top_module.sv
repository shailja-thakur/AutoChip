module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [3:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		out_bytes <= 0;
		done <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (in[2]) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
			
			BYTE2: begin
				if (in[2]) begin
					state <= BYTE3;
				end else begin
					state <= BYTE1;
				end
			end
			
			BYTE3: begin
				state <= DONE;
			end
			
			DONE: begin
				if (in[2]) begin
					state <= DONE;
				end else begin
					state <= BYTE1;
				end
			end
		endcase
		
		if (state == DONE) begin
			done <= 1;
			out_bytes <= out_bytes;
		end else begin
			done <= 0;
			out_bytes <= out_bytes << 8;
			out_bytes[7:0] <= in;
		end
	end
end

endmodule
