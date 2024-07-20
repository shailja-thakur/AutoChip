module top_module (
	input wire clk,
	input wire aresetn,
	input wire x,
	output reg z
);

// Define states
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

// Define state register
reg [1:0] state;

// Define output register
reg out_reg;

// Assign next state and output
always @(posedge clk or negedge aresetn) begin
	if (!aresetn)
		state <= S0;
	else begin
		case(state)
			S0: begin
				if (x)
					state <= S1;
				else
					state <= S0;
			end
			
			S1: begin
				if (x)
					state <= S2;
				else
					state <= S0;
			end
			
			S2: begin
				if (x)
					state <= S1;
				else
					state <= S0;
			end
		endcase
	end
end

// Assign output
always @(state, x) begin
	if (state == S2 && !x)
		out_reg <= 1'b1;
	else
		out_reg <= 1'b0;
end

// Assign output to z
always @(posedge clk or negedge aresetn) begin
	if (!aresetn)
		z <= 1'b0;
	else
		z <= out_reg;
end

endmodule
