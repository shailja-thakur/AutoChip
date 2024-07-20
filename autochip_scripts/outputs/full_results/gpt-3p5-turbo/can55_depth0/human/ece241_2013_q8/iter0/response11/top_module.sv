module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [1:0] state, next_state;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

// State transition and output logic
always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		state <= S0; // Initial state
		z <= 1'b0; // Output is set to 0
	end
	else begin
		state <= next_state; //State transition

		case(state)
			S0: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x == 1'b0)
					next_state = S0;
				else if (x == 1'b1)
					next_state = S2;
				else
					next_state = S1;
			end
			S2: begin
				if (x == 1'b0)
					next_state = S0;
				else if (x == 1'b1)
					next_state = S3;
				else
					next_state = S2;
			end
			S3: begin
				if (x == 1'b0)
					next_state = S0;
				else if (x == 1'b1)
					next_state = S2;
				else
					next_state = S3;
			end
		endcase
	end
end

// Output generation
always @(state) begin
	if (state == S1)
		z = 1'b0;
	else if (state == S3)
		z = 1'b1;
	else
		z = 1'b0;
end

endmodule
