module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

reg [2:0] state;
reg last_bit;
reg [7:0] data;
reg stop_error;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		data <= 8'b0;
		stop_error <= 1'b0;
		done <= 1'b0;
	end else begin
		case (state)
			3'b000: begin // idle state
				if (in == 1'b0) begin
					state <= 3'b001; // transition to start bit state
				end
			end
			
			3'b001: begin // start bit state
				state <= 3'b010; // transition to data bit state
				data <= 8'b0;
				last_bit <= in;
			end
			
			3'b010: begin // data bit state
				if (in == last_bit) begin
					data <= {data[6:0], in}; // shift in received bit
				end else begin
					state <= 3'b011; // transition to stop bit state
					last_bit <= in;
					stop_error <= 1'b1;
				end
				last_bit <= in;
			end
			
			3'b011: begin // stop bit state
				if (in == 1'b1) begin
					state <= 3'b000; // transition to idle state
					done <= 1'b1;
					stop_error <= 1'b0;
				end else begin
					state <= 3'b100; // transition to error state
					stop_error <= 1'b1;
				end
			end
			
			3'b100: begin // error state
				if (in == 1'b0) begin
					state <= 3'b000; // transition to idle state
				end
				stop_error <= 1'b0;
			end
		endcase
	end
end

endmodule
