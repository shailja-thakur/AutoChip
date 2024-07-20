module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always @ (state, in)
	begin
		case(state)
			2'b00: begin // state A
				if (in == 0)
				begin
					next_state = 2'b00; // next state A
					out = 0; // output 0
				end
				else
				begin
					next_state = 2'b01; // next state B
					out = 0; // output 0
				end
			end
			
			2'b01: begin // state B
				if (in == 0)
				begin
					next_state = 2'b10; // next state C
					out = 0; // output 0
				end
				else
				begin
					next_state = 2'b01; // next state B
					out = 0; // output 0
				end
			end
			
			2'b10: begin // state C
				if (in == 0)
				begin
					next_state = 2'b00; // next state A
					out = 0; // output 0
				end
				else
				begin
					next_state = 2'b11; // next state D
					out = 0; // output 0
				end
			end
			
			2'b11: begin // state D
				if (in == 0)
				begin
					next_state = 2'b10; // next state C
					out = 1; // output 1
				end
				else
				begin
					next_state = 2'b01; // next state B
					out = 0; // output 0
				end
			end
		endcase
	end

endmodule
