module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [2:0] state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // initial state
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			3'b000: begin // state A
				if (w)
					next_state = 3'b001; // state B
				else
					next_state = 3'b000; // state A
			end
			
			3'b001: begin // state B
				if (w)
					next_state = 3'b010; // state C
				else
					next_state = 3'b100; // state D
			end
			
			3'b010: begin // state C
				if (w)
					next_state = 3'b110; // state E
				else
					next_state = 3'b100; // state D
			end
			
			3'b100: begin // state D
				if (w)
					next_state = 3'b011; // state F
				else
					next_state = 3'b000; // state A
			end
			
			3'b110: begin // state E
				if (w)
					next_state = 3'b110; // state E
				else
					next_state = 3'b100; // state D
			end
			
			3'b011: begin // state F
				if (w)
					next_state = 3'b010; // state C
				else
					next_state = 3'b100; // state D
			end
		endcase
	end
	
	assign z = (state == 3'b110 || state == 3'b011) ? 1'b1 : 1'b0;
endmodule
