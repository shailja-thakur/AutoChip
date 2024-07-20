module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;
reg start_bit;
reg [7:0] data_bit;
reg stop_bit;

assign done = (state == 3);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		start_bit <= 0;
		data_bit <= 0;
		stop_bit <= 0;
	end else begin
		case (state)
			0: begin // Wait for start bit
				if (in == 0) begin
					state <= 1;
					start_bit <= 1;
				end else begin
					state <= 0;
					start_bit <= 0;
				end
			end
			1: begin // Receive data bits
				data_bit <= {data_bit[6:0], in};
				state <= (data_bit == 8'b11111110) ? 2 : 1;
			end
			2: begin // Wait for stop bit
				if (in == 1) begin
					state <= 3;
					stop_bit <= 1;
				end else begin
					state <= 0;
					start_bit <= 0;
				end
			end
			3: begin // Byte received, wait for next start bit
				if (in == 0) begin
					state <= 1;
					start_bit <= 1;
				end else begin
					state <= 3;
					start_bit <= 0;
				end
			end
		endcase
	end
end

endmodule
