module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

reg [3:0] state, next_state; // Define state and next_state as a 4-bit register

// Define states using localparams
localparam A = 4'b0000;
localparam B = 4'b0001;
localparam C = 4'b0010;
localparam S10 = 4'b0011;
localparam S11 = 4'b0100;
localparam S20 = 4'b0101;
localparam S21 = 4'b0110;
localparam S22 = 4'b0111;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A; // Reset state to A
	end else begin
		state <= next_state; // Update state with next_state
	end
end

always @* begin
	case (state)
		A: begin
			if (s) begin
				next_state = B; // If s is asserted, next state is B
			end
		end
		B, C: begin
			if (w) begin
				next_state = S11; // If w is asserted, next state is S11
			end else begin
				next_state = S10; // Otherwise next state is S10
			end
		end
		S10: begin
			if (w) begin
				next_state = S21; // If w is asserted, next state is S21
			end else begin
				next_state = S20; // Otherwise next state is S20
			end
		end
		S11: begin
			if (w) begin
				next_state = S22; // If w is asserted, next state is S22
			end else begin
				next_state = S21; // Otherwise next state is S21
			end
		end
		S20: begin
			next_state = B; // Next state is B
		end
		S21: begin
			if (w) begin
				next_state = C; // If w is asserted, next state is C
			end else begin
				next_state = B; // Otherwise next state is B
			end
		end
		S22: begin
			if (w) begin
				next_state = B; // If w is asserted, next state is B
			end else begin
				next_state = C; // Otherwise next state is C
			end
		end
	endcase
end

always @(posedge clk) begin
	if (reset) begin
		z <= 0; // Reset z to 0
	end else begin
		if (state == S11 || state == S20) begin
			z <= 1; // If current state is S11 or S20, set z to 1
		end else begin
			z <= 0; // Otherwise, set z to 0
		end
	end
end

endmodule
