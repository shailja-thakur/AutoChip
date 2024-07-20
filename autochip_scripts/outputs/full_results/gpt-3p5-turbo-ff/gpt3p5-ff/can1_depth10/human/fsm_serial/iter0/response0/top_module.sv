module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
	end else begin
		case (state)
			3'b000: begin // idle state
				if (in == 1'b0) begin
					state <= 3'b001; // transition to start bit state
				end
			end
			
			3'b001: begin // start bit state
				state <= 3'b010; // transition to data bit state
			end
			
			3'b010: begin // data bit state
				if (in == 1'b1) begin
					state <= 3'b011; // transition to stop bit state
				end
			end
			
			3'b011: begin // stop bit state
				if (in == 1'b0) begin
					state <= 3'b000; // transition to idle state
				end else begin
					state <= 3'b100; // transition to error state
				end
			end
			
			3'b100: begin // error state
				if (in == 1'b0) begin
					state <= 3'b000; // transition to idle state
				end
			end
		endcase
	end
end

assign done = (state == 3'b011);

endmodule
