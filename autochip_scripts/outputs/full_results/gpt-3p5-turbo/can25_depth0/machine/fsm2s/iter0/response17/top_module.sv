module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output wire out
);

	reg [1:0] state, next_state;

	// State machine definition
	always@(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			state <= 2'b00;
		end 
		else begin
			state <= next_state;
		end
	end

	// Next state logic
	always@(state or j or k) begin
		case(state)
			2'b00: begin // State A
				if(j == 1'b1) begin
					next_state = 2'b01; // Transition to state B
				end
				else begin
					next_state = 2'b00; // Stay in state A
				end
			end
			2'b01: begin // State B
				if(k == 1'b1) begin
					next_state = 2'b00; // Transition to state A
				end
				else begin
					next_state = 2'b01; // Stay in state B
				end
			end
		endcase
	end

	// Output assignment
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;
  
endmodule
