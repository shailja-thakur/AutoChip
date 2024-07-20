module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg start_found;
reg [7:0] data_bits;
reg parity_check;
reg stop_found;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		start_found <= 0;
		data_bits <= 0;
		parity_check <= 0;
		stop_found <= 0;
		out_byte <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin // IDLE state
				if (in == 1'b0) begin
					state <= 1;
				end
			end
			1: begin // START_BIT state
				if (in == 1'b0) begin
					state <= 2;
					start_found <= 1;
					data_bits <= 0;
					parity_check <= 0;
				end else begin
					state <= 0;
				end
			end
			2: begin // RECEIVE DATA BITS state
				if (data_bits == 8) begin
					state <= 3;
				end else begin
					data_bits <= {data_bits[6:0], in};
					parity_check <= parity_check ^ in;
				end
			end
			3: begin // RECEIVE STOP BIT state
				if (in == 1'b1) begin
					if (parity_check == 0 && start_found) begin
						stop_found <= 1;
						out_byte <= data_bits;
						done <= 1;
					end
					state <= 0;
					start_found <= 0;
					data_bits <= 0;
					parity_check <= 0;
				end
			end
		endcase
	end
end

endmodule
