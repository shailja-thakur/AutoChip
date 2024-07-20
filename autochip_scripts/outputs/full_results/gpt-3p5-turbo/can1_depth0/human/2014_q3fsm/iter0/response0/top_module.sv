module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// define states
parameter A = 0;
parameter B = 1;
parameter C = 2;

reg current_state;
reg next_state;
reg [2:0] w_count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= A;
		next_state <= A;
		w_count <= 3'b000;
	end else begin
		current_state <= next_state;
		
		case (current_state)
			A: begin
				if (s) begin
					next_state <= B;
				end else begin
					next_state <= A;
				end
			end
			
			B: begin
				if (w) begin
					w_count <= w_count + 1;
				end
				
				next_state <= C;
			end
			
			C: begin
				if (w) begin
					w_count <= w_count + 1;
				end
				
				next_state <= A;
			end
		endcase
	end
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		z <= 0;
	end else begin
		if (current_state == B && (w_count == 2'b10)) begin
			z <= 1;
		end else begin
			z <= 0;
		end
	end
end

endmodule
