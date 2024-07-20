module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	// Declare state register
	reg [1:0] state;
	
	// Declare output wire
	wire out;
	
	// Implement synchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b0;
		else
			state <= nextState; // calculate next state based on inputs
	end
	
	// Assign output based on current state
	assign out = (state == 2'b1) ? 1'b1 : 1'b0;
	
	// Determine next state based on inputs and current state
	always @(*) begin
		case (state)
			2'b00: begin
				if (j)
					nextState = 2'b01;
				else
					nextState = 2'b00;
			end
			2'b01: begin
				if (k)
					nextState = 2'b00;
				else
					nextState = 2'b01;
			end
		endcase
	end
endmodule
