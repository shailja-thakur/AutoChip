module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: begin // BYTE1 state
					if (in[2])
						state <= 3'b001; // Transition to BYTE2 state
					else
						state <= 3'b000; // Remain in BYTE1 state
				end
				3'b001: begin // BYTE2 state
					state <= 3'b010; // Transition to BYTE3 state
				end
				3'b010: begin // BYTE3 state
					state <= 3'b011; // Transition to DONE state
				end
				3'b011: begin // DONE state
					if (in[2])
						state <= 3'b001; // Transition back to BYTE2 state
					else
						state <= 3'b000; // Transition back to BYTE1 state
				end
				default: state <= 3'b000; // Reset to BYTE1 state if unknown state
			endcase
		end
	end
	
	assign done = (state == 3'b011); // done signal is asserted when in DONE state

endmodule
