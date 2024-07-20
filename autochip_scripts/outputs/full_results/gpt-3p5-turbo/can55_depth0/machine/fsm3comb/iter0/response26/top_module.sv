module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

	reg [1:0] current_state;
	always_comb begin
		case(state)
			2'b00: begin
				if(in == 1'b1)
					next_state = 2'b01;
				else
					next_state = 2'b00;
			end
			2'b01: begin
				if(in == 1'b1)
					next_state = 2'b10;
				else
					next_state = 2'b01;
			end
			2'b10: begin
				if(in == 1'b1)
					next_state = 2'b11;
				else
					next_state = 2'b00;
			end
			2'b11: begin
				if(in == 1'b1)
					next_state = 2'b01;
				else
					next_state = 2'b10;
			end
			default: next_state = state; // Added default case to handle unknown state value
		endcase
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Changed '=' to '==' for equality check
	
	always @(posedge clk) // Added a clocking block for synchronous assignment of next_state
	begin
	    if (reset) // Add reset condition to reset the state machine
	        current_state <= 2'b00;
	    else
	        current_state <= next_state;
	end
	
	assign state = current_state;
	
endmodule
