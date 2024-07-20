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
		z <= 0;
	end else begin
		state <= next_state;
		
		// FSM logic
		case (state)
			A: begin
				if (s) begin
					next_state <= B;
				end else begin
					next_state <= A;
				end
			end
			B: begin
				if ((w == 1) && ($countones(w) == 2)) begin
					z <= 1;
				end else begin
					z <= 0;
				end
				
				next_state <= A;
			end
		endcase
	end
end

endmodule
