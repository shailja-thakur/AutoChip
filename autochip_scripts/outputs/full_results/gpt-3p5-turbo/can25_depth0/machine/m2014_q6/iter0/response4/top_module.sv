module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	reg [2:0] current_state, next_state;
	always @(posedge clk) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	always @(current_state, w) begin
		case (current_state)
			A: begin
				if (w) begin
					next_state <= A;
				end else begin
					next_state <= B;
				end
			end
			B: begin
				if (w) begin
					next_state <= D;
				end else begin
					next_state <= C;
				end
			end
			C: begin
				if (w) begin
					next_state <= D;
				end else begin
					next_state <= E;
				end
			end
			D: begin
				if (w) begin
					next_state <= A;
				end else begin
					next_state <= F;
				end
			end
			E: begin
				if (w) begin
					next_state <= D;
				end else begin
					next_state <= E;
				end
			end
			F: begin
				if (w) begin
					next_state <= D;
				end else begin
					next_state <= C;
				end
			end
			default: next_state <= A;
		endcase
	end
	
	assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;
endmodule
