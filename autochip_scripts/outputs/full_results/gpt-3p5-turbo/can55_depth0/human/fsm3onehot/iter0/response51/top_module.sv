module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	always @(state)
		begin

			case(state)

				4'b0001: begin
					if(in)
						begin
							next_state = 4'b0010; //Transition to state B
							out = 1'b0; //Output is 0
						end
					else
						begin
							next_state = 4'b0001; //Remain in state A
							out = 1'b0; //Output is 0
						end
				end

				4'b0010: begin
					if(in)
						begin
							next_state = 4'b0010; //Remain in state B
							out = 1'b0; //Output is 0
						end
					else
						begin
							next_state = 4'b0100; //Transition to state C
							out = 1'b0; //Output is 0
						end
				end

				4'b0100: begin
					if(in)
						begin
							next_state = 4'b0001; //Transition to state A
							out = 1'b0; //Output is 0
						end
					else
						begin
							next_state = 4'b1000; //Transition to state D
							out = 1'b0; //Output is 0
						end
				end

				4'b1000: begin
					if(in)
						begin
							next_state = 4'b0100; //Transition to state C
							out = 1'b1; //Output is 1
						end
					else
						begin
							next_state = 4'b0010; //Remain in state B
							out = 1'b0; //Output is 0
						end
				end

			endcase

		end

endmodule
