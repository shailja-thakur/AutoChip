module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

// Define states
parameter OFF = 0;
parameter ON = 1;

// Define current state and next state variables
reg [1:0] state, next_state;

// Define output register
reg out_reg;

// Assign initial state
always @ (posedge clk or posedge areset) begin
	if (areset)
		state <= OFF;
	else
		state <= next_state;
end

// Assign next state and output values
always @ (*) begin
	case (state)
		OFF: begin
			if (j) begin
				next_state = ON;
				out_reg = 0;
			end else begin
				next_state = OFF;
				out_reg = 0;
			end
		end
		
		ON: begin
			if (k) begin
				next_state = OFF;
				out_reg = 1;
			end else begin
				next_state = ON;
				out_reg = 1;
			end
		end
	endcase
end

// Assign output
assign out = out_reg;

endmodule
