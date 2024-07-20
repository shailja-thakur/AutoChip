module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define states
	parameter [2:0] A = 3'b000;
	parameter [2:0] B = 3'b001;
	parameter [2:0] C = 3'b010;
	parameter [2:0] D = 3'b011;
	parameter [2:0] E = 3'b100;
	parameter [2:0] F = 3'b101;

	// Define state registers
	reg [2:0] state, next_state;
	
	// Define output reg
	reg out_reg;
	
	// Define Moore output
	assign z = out_reg;
	
	// State transition and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or w) begin
		case (state)
			A: begin
				if (w) begin
					next_state = A;
					out_reg = 0;
				end else begin
					next_state = B;
					out_reg = 0;
				end
			end
			B: begin
				if (w) begin
					next_state = D;
					out_reg = 0;
				end else begin
					next_state = C;
					out_reg = 0;
				end
			end
			C: begin
				if (w) begin
					next_state = D;
					out_reg = 0;
				end else begin
					next_state = E;
					out_reg = 0;
				end
			end
			D: begin
				if (w) begin
					next_state = A;
					out_reg = 0;
				end else begin
					next_state = F;
					out_reg = 0;
				end
			end
			E: begin
				if (w) begin
					next_state = D;
					out_reg = 1;
				end else begin
					next_state = E;
					out_reg = 1;
				end
			end
			F: begin
				if (w) begin
					next_state = D;
					out_reg = 1;
				end else begin
					next_state = C;
					out_reg = 1;
				end
			end
		endcase
	end
endmodule
