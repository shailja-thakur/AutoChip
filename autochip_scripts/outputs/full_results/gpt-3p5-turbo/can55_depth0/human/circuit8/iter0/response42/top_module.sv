module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
	// state variables
	reg state;
	reg next_state;
	
	// state transition logic
	case (state)
		0: begin // initial state
			if (a) begin
				next_state = 1;
			end else begin
				next_state = 0;
			end
		end
		
		1: begin // state 1
			if (a) begin
				next_state = 2;
			end else begin
				next_state = 1;
			end
		end
		
		2: begin // state 2
			if (a) begin
				next_state = 3;
			end else begin
				next_state = 2;
			end
		end
		
		3: begin // state 3
			if (a) begin
				next_state = 0;
			end else begin
				next_state = 3;
			end
		end
	endcase
	
	// output logic
	case (state)
		0: begin // initial state
			p <= 0;
			q <= 0;
		end
		
		1: begin // state 1
			p <= 0;
			q <= 0;
		end
		
		2: begin // state 2
			p <= 1;
			q <= 0;
		end
		
		3: begin // state 3
			p <= 1;
			q <= 1;
		end
	endcase
	
	// state update
	state <= next_state;
end

endmodule
