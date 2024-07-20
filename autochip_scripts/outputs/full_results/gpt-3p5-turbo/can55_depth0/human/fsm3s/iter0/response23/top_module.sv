module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state;
	reg out;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b0;
		else begin
			case(state)
				2'b00: begin // State A
					if (in)
						state <= 2'b01; // Next state if in=1
					else
						state <= 2'b00; // Next state if in=0
				end
				
				2'b01: begin // State B
					if (in)
						state <= 2'b01; // Next state if in=1
					else
						state <= 2'b10; // Next state if in=0
				end
				
				2'b10: begin // State C
					if (in)
						state <= 2'b01; // Next state if in=1
					else
						state <= 2'b11; // Next state if in=0
				end
				
				2'b11: begin // State D
					if (in)
						state <= 2'b10; // Next state if in=1
					else
						state <= 2'b01; // Next state if in=0
				end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			2'b00: out = 1'b0; // Output in state A
			2'b01: out = 1'b0; // Output in state B
			2'b10: out = 1'b0; // Output in state C
			2'b11: out = 1'b1; // Output in state D
		endcase
	end
endmodule
