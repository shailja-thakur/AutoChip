module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	reg current_state;
	reg next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	always @* begin
		case (current_state)
			A: begin
				if (s == 1'b1) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			
			B: begin
				next_state = A;
			end
			
			default: begin
				next_state = A;
			end
		endcase
	end
	
	reg [2:0] w_count;
	
	always @(posedge clk) begin
		if (reset) begin
			w_count <= 0;
		end else begin
			if (current_state == B) begin
				if (w) begin
					w_count <= w_count + 1;
				end
			end
		end
	end
	
	always @(posedge clk) begin
		if (reset) begin
			z <= 0;
		end else begin
			if (w_count == 2) begin
				z <= 1;
			end else begin
				z <= 0;
			end
		end
	end
	
endmodule
