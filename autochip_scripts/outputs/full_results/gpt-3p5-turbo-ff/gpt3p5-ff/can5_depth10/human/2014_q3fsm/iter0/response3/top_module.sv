module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case(state)
		A: begin
			z <= 0;
			if (s == 1) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		B: begin
			if(w == 1) begin
				next_state = B;
			end else begin
				next_state = A;
			end
			
			if (w == 1) begin
				// Count the number of '1's in the next three clock cycles
				if (w == 1 && #1 w == 1 && #1 w == 0) begin
					z <= 1;
				else begin
					z <= 0;
				end
			end
		end
	endcase
end
endmodule
