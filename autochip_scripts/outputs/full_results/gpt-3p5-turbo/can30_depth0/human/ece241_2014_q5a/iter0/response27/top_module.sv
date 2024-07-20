module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Define the states of the state machine
	typedef enum logic [1:0] {S0, S1, S2} state_type;
	
	// Define the output signal
	logic signed [31:0] z_output;
	
	// Define the current state variable
	state_type current_state;
	
	// Define the next state variable
	state_type next_state;
	
	// Define the output signal
	assign z = z_output;
	
	// Define the sequential logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= S0;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Define the combinational logic
	always_comb begin
		case (current_state)
			S0: begin
				if (areset) begin
					z_output <= 0;
					next_state <= S0;
				end else if (x) begin
					z_output <= -x;
					next_state <= S1;
				end else begin
					z_output <= 0;
					next_state <= S0;
				end
			end
			S1: begin
				if (areset) begin
					z_output <= 0;
					next_state <= S0;
				end else if (x) begin
					z_output <= -x;
					next_state <= S1;
				end else begin
					z_output <= 0;
					next_state <= S2;
				end
			end
			S2: begin
				if (areset) begin
					z_output <= 0;
					next_state <= S0;
				end else if (x) begin
					z_output <= -x;
					next_state <= S1;
				end else begin
					z_output <= 0;
					next_state <= S2;
				end
			end
			default: begin
				z_output <= 0;
				next_state <= S0;
			end
		endcase
	end
endmodule
