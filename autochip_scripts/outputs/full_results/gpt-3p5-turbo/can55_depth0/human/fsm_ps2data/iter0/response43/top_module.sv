module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] fifo [2:0];
	reg [1:0] state;
	reg [2:0] byte_count;
	reg done_temp;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 0;
			done_temp <= 0;
			byte_count <= 0;
			state <= 0;
		end else begin
			case (state)
				0: begin // Discard bytes until in[3] = 1
					if (in[3] == 1) begin
						fifo[0][7:0] <= in;
						state <= 1;
					end
				end
				1: begin // Store byte 1 in fifo[0]
					fifo[0][15:8] <= in;
					state <= 2;
				end
				2: begin // Store byte 2 in fifo[1]
					fifo[1][15:8] <= in;
					state <= 3;
				end
				3: begin // Store byte 3 in fifo[2]
					fifo[2][15:8] <= in;
					byte_count <= byte_count + 1;
					state <= 4;
				end
				4: begin // Output message and reset FIFOs and byte_count
					fifo[2][7:0] <= in;
					out_bytes <= {fifo[0][23:16], fifo[1][23:16], fifo[2][23:16]};
					done_temp <= 1;
					state <= 0;
					byte_count <= 0;
				end
			endcase
		end
	end

	assign done = done_temp;

endmodule
