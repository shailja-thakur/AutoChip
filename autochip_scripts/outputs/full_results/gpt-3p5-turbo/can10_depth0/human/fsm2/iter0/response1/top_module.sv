module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
	
	// State enumeration
	typedef enum [1:0] {OFF, ON} state_t;
	
	// State register
	reg [1:0] current_state;
	
	// Asynchronous reset
	always @(posedge areset)
	begin
		if (areset)
			current_state <= OFF;
		else
			current_state <= current_state;
	end
	
	// Sequential logic
	always @(posedge clk)
	begin
		if (areset)
			current_state <= OFF;
		else
		begin
			case (current_state)
				OFF: if(j) current_state <= ON;
				     else current_state <= OFF;
				ON: if(k) current_state <= OFF;
				    else current_state <= ON;
				default: current_state <= OFF;
			endcase
		end
	end
	
	// Combinational logic for outputs
	always @*
	begin
		case (current_state)
			OFF: out = 0;
			ON: out = 1;
			default: out = 0;
		endcase
	end
	
endmodule
