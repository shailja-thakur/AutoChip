module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01; // Initial state B
		end else begin
			case(state)
				2'b00: begin // State A
					if (in) begin
						state <= 2'b00; // Transition to state A on input 1
					else
						state <= 2'b01; // Transition to state B on input 0
					end
				end
				2'b01: begin // State B
					if (in) begin
						state <= 2'b01; // Transition to state B on input 1
					else
						state <= 2'b10; // Transition to state A on input 0
					end
				end
				default: state <= 2'b01;
			endcase
		end
	end
	
	assign out = (state == 2'b00) ? 1'b0 : 1'b1; // Output is low in state A, high in state B
endmodule
