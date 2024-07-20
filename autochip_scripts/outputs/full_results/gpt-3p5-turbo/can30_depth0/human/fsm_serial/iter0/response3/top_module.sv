module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg done;

always @(posedge clk) begin
	if (reset) begin
		state <= 3'b000;
		done <= 1'b0;
	end else begin
		case(state)
			3'b000: begin // Idle state
				if (in == 1'b0) begin // Start bit detected
					state <= 3'b001; // Transition to the next state
				end else begin
					state <= 3'b000; // Stay in the current state
				end
			end
			3'b001: begin // Receiving data bits state
				state <= 3'b010; // Transition to the next state
			end
			3'b010: begin // Receiving data bits state
				state <= 3'b011; // Transition to the next state
			end
			3'b011: begin // Receiving data bits state
				state <= 3'b100; // Transition to the next state
			end
			3'b100: begin // Receiving data bits state
				state <= 3'b101; // Transition to the next state
			end
			3'b101: begin // Receiving data bits state
				state <= 3'b110; // Transition to the next state
			end
			3'b110: begin // Receiving data bits state
				state <= 3'b111; // Transition to the next state
			end
			3'b111: begin // Receiving data bits state
				if (in == 1'b1) begin // Stop bit detected
					state <= 3'b000; // Transition to the idle state
					done <= 1'b1; // Indicate byte reception completed
				end else begin
					state <= 3'b111; // Stay in the current state
				end
			end
			default: begin
				state <= 3'b000;
				done <= 1'b0;
			end
		endcase
	end
end

endmodule
