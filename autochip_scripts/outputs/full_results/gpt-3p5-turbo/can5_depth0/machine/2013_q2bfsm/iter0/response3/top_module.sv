module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

// States
parameter A = 2'b00;   // Initial state
parameter B = 2'b01;
parameter S0 = 2'b10;
parameter S1 = 2'b11;
parameter S10 = 3'b100;
parameter G1 = 3'b101;
parameter G2 = 3'b110;
parameter P0 = 3'b111;
parameter P1 = 3'b000;

// Registers for current state and next state
reg [2:0] current_state;
reg [2:0] next_state;

// Outputs
assign f = (current_state == B);
assign g = (current_state == G1) || (current_state == G2) || (current_state == P1);

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		// Reset the FSM on resetn signal
		current_state <= A;
	end
	else begin
		// Update the next state based on current state, x, and y
		case (current_state)
			A: begin
				if (x) next_state <= B;
				else next_state <= S0;
			end
			B: next_state <= S0;
			S0: begin
				if (x) next_state <= S1;
				else next_state <= S0;
			end
			S1: begin
				if (x) next_state <= S1;
				else next_state <= S10;
			end
			S10: begin
				if (x) next_state <= G1;
				else next_state <= S0;
			end
			G1: begin
				if (y) next_state <= P1;
				else next_state <= G2;
			end
			G2: begin
				if (y) next_state <= P1;
				else next_state <= P0;
			end
			P0: next_state <= P0;
			P1: next_state <= P1;
		endcase
	end
end

// Update the current state with the next state
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		// Reset the FSM on resetn signal
		current_state <= A;
	end
	else begin
		current_state <= next_state;
	end
end

endmodule
