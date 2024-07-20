module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset == 1) begin
			state <= 2'b00;		// initial state is A
		end else begin
			case(state)
				2'b00: begin		// state A
					if (in == 1)
						state <= 2'b01;	// change to state B
					else
						state <= 2'b00;	// remain in state A
				end
				
				2'b01: begin		// state B
					if (in == 1)
						state <= 2'b01;	// remain in state B
					else
						state <= 2'b10;	// change to state C
				end
				
				2'b10: begin		// state C
					if (in == 1)
						state <= 2'b11;	// change to state D
					else
						state <= 2'b00;	// change to state A
				end
				
				2'b11: begin		// state D
					if (in == 1)
						state <= 2'b01;	// change to state B
					else
						state <= 2'b10;	// change to state C
				end
			endcase
		end
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
