module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	
	// Define state code using parameters
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define state flip-flops
	reg [1:0] current_state, next_state;
	
	// Define combinational logic for next state
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Define state table
	always @(current_state, w) begin
		case (current_state)
			A: begin
				if (w) begin
					next_state <= B;
				end else begin
					next_state <= A;
				end
			end
			B: begin
				if (w) begin
					next_state <= C;
				end else begin
					next_state <= D;
				end
			end
			C: begin
				if (w) begin
					next_state <= E;
				end else begin
					next_state <= D;
				end
			end
			D: begin
				if (w) begin
					next_state <= F;
				end else begin
					next_state <= A;
				end
			end
			E: begin
				if (w) begin
					next_state <= E;
				end else begin
					next_state <= D;
				end
			end
			F: begin
				if (w) begin
					next_state <= C;
				end else begin
					next_state <= D;
				end
			end
		endcase
	end
	
	// Assign output based on current state
	always @(current_state) begin
		case (current_state)
			E, F: begin
				z = 1;
			end
			default: begin
				z = 0;
			end
		endcase
	end
	
endmodule
