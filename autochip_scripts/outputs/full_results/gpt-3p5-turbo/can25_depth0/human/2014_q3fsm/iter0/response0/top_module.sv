module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define current_state and next_state
reg [1:0] current_state;
reg [1:0] next_state;

// Define count to check the value of w in the next three clock cycles
reg [2:0] count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= A;
		next_state <= A;
		count <= 3'b0;
		z <= 1'b0;
	end else begin
		current_state <= next_state;
		if (count == 3'b0) begin
			if (current_state == B && w) begin
				next_state <= C;
			end else begin
				next_state <= A;
			end
		end else if (count < 3'b3) begin
			next_state <= current_state;
		end else begin
			if (current_state == C && w) begin
				z <= 1'b1;
			end else begin
				z <= 1'b0;
			end
			next_state <= D;
		end
		
		// Increment count if the FSM is in state B or C
		if (current_state == B || current_state == C) begin
			count <= count + 1'b1;
		end else begin
			count <= 3'b0;
		end
	end
end

endmodule
