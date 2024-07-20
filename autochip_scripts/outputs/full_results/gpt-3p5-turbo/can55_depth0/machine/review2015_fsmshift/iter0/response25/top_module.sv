module top_module(
	input clk,
	input reset,
	output reg shift_ena,
	output reg [2:0] state
);

	always @(posedge clk) begin
		
		// State transition logic
		if (reset) begin
			state <= 3'b000; // Reset to B0
		end else begin
			case (state)
				3'b000: begin // B0
					state <= 3'b001; // Transition to B1
				end
				3'b001: begin // B1
					state <= 3'b010; // Transition to B2
				end
				3'b010: begin // B2
					state <= 3'b011; // Transition to B3
				end
				3'b011: begin // B3
					state <= 3'b100; // Transition to Done
				end
				default: begin // Done
					state <= 3'b100; // Remain in Done state
				end
			endcase
		end
		
		// shift_ena logic
		if (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) begin
			shift_ena <= 1; // Enable shift
		end else begin
			shift_ena <= 0; // Disable shift
		end
		
	end
	
endmodule
