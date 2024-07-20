module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define state enumeration
typedef enum logic [3:0] {
	A,
	B,
	C,
	S10,
	S11,
	S20,
	S21,
	S22
} state_t;

// Define state variable and initialize to state A
reg state_t current_state = A;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= A;
	end else begin
		case (current_state)
			A: if (s) begin
					current_state <= B;
			   end
			   else begin
			   		current_state <= A;
			   end
			B: if (w) begin
					current_state <= S11;
			   end
			   else begin
			   		current_state <= S10;
			   end
			C: if (w) begin
					current_state <= S11;
			   end
			   else begin
			   		current_state <= S10;
			   end
			S10: if (w) begin
					current_state <= S21;
				   end
				   else begin
			   			current_state <= S20;
				   end
			S11: if (w) begin
					current_state <= S22;
				   end
				   else begin
			   			current_state <= S21;
				   end
			S20: current_state <= B;
			S21: if (w) begin
					current_state <= C;
				   end
				   else begin
			   			current_state <= B;
				   end
			S22: if (w) begin
					current_state <= B;
				   end
			   	   else begin
			   			current_state <= C;
			   	   end
		endcase
	end
end

always @(posedge clk) begin
	case (current_state)
		A: begin
				// Describe behavior for state A
			end
		B: begin
				// Describe behavior for state B
			end
		C: begin
				// Describe behavior for state C
			end
		S10: begin
				// Describe behavior for state S10
			end
		S11: begin
				// Describe behavior for state S11
			end
		S20: begin
				// Describe behavior for state S20
			end
		S21: begin
				// Describe behavior for state S21
			end
		S22: begin
				// Describe behavior for state S22
			end
	endcase
end

endmodule
