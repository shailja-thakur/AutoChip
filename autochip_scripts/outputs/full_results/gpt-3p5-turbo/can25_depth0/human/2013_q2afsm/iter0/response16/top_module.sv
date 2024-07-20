module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state;
reg [3:1] next_state;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= 3'b000; // Initializing state to A
	else
		state <= next_state;
end

always@(*) begin
next_state = state;

case(state)
	3'b000: begin // State A
		if((~r[1]) && (~r[2]) && (~r[3]))
			next_state = 3'b000; // Stay in state A
		else if(r[1])
			next_state = 3'b010; // Transition to state B
		else if((~r[1]) && r[2])
			next_state = 3'b001; // Transition to state C
		else if((~r[1]) && (~r[2]) && (~r[3]))
			next_state = 3'b011; // Transition to state D
	end
	
	3'b001: begin // State C
		if(r[2])
			next_state = 3'b001; // Stay in state C
		else
			next_state = 3'b000; // Transition back to state A
	end
	
	3'b010: begin // State B
		if(r[1])
			next_state = 3'b010; // Stay in state B
		else if(r[3])
			next_state = 3'b100; // Transition to state E
		else
			next_state = 3'b000; // Transition back to state A
	end
	
	3'b011: begin // State D
		next_state = 3'b000; // Transition back to state A
	end
	
	3'b100: begin // State E
		if(r[3])
			next_state = 3'b100; // Stay in state E
		else
			next_state = 3'b010; // Transition back to state B
	end
end // end case statement

end // end always block

// Output assignment
always @(*) begin
	g[1] = (state == 3'b010) || (state == 3'b100);
	g[2] = (state == 3'b001) || (state == 3'b101);
	g[3] = state == 3'b101;
end

endmodule
