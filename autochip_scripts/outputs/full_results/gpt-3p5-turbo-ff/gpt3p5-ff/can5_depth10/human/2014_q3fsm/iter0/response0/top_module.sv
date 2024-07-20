module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
 
reg [1:0] state, next_state;
 
parameter A = 2'b00;
parameter B = 2'b01;
 
always @(posedge clk) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end
 
always @(*) begin
	case (state)
		A: begin
			if (s == 0) begin
				next_state = A;
			end else if (s == 1) begin
				next_state = B;
			end
		end
		B: begin
			if (w == 1'b1) begin
				next_state = B;
			end else begin
				if ((w[0] == 1'b1 && w[1] == 1'b1) || 
				    (w[0] == 1'b1 && w[2] == 1'b1) ||
				    (w[1] == 1'b1 && w[2] == 1'b1)) begin
					next_state = B;
					z = 1;
				end else begin
					next_state = A;
					z = 0;
				end
			end
		end
	endcase
end
 
endmodule
