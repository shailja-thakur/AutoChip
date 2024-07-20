module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;
	
	always @(posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			state <= 3'b000; // Initializing the state to A
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case (state)
			3'b000: begin // State A
				if (x == 1'b0) begin
					next_state = 3'b000; // Next state is A
				end else begin
					next_state = 3'b001; // Next state is B
				end
			end
			
			3'b001: begin // State B
				if (x == 1'b0) begin
					next_state = 3'b001; // Next state is B
				end else begin
					next_state = 3'b100; // Next state is E
				end
			end
			
			3'b010: begin // State C
				if (x == 1'b0) begin
					next_state = 3'b010; // Next state is C
				end else begin
					next_state = 3'b001; // Next state is B
				end
			end
			
			3'b011: begin // State D
				if (x == 1'b0) begin
					next_state = 3'b001; // Next state is B
				end else begin
					next_state = 3'b010; // Next state is C
				end
			end
			
			3'b100: begin // State E
				if (x == 1'b0) begin
					next_state = 3'b011; // Next state is D
				end else begin
					next_state = 3'b100; // Next state is E
				end
			end
			
			default: next_state = 3'b000; // Default state is A
		endcase
	end
	
	always @(posedge clk) begin
		if (state == 3'b100 || state == 3'b101) begin // State D or E
			z <= 1'b1;
		end else begin
			z <= 1'b0;
		end
	end
	
endmodule
