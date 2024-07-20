module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

reg current_state;
reg next_state;

// Initialize variables
initial begin
	current_state <= 0;
	next_state <= 0;
end

// Sequential logic
always @(posedge clock) begin
	current_state <= next_state;
	
	case (current_state)
		0: begin
			p <= 0;
			q <= 0;
			if (clock == 1 && a == 0)
				next_state <= 0;
			else if (clock == 1 && a == 1)
				next_state <= 1;
		end
		1: begin
			p <= 1;
			q <= 0;
			if (clock == 1 && a == 0)
				next_state <= 0;
			else if (clock == 1 && a == 1)
				next_state <= 2;
		end
		2: begin
			p <= 1;
			q <= 1;
			if (clock == 1 && a == 0)
				next_state <= 0;
			else if (clock == 1 && a == 1)
				next_state <= 1;
		end
	endcase
end

endmodule
