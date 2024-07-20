module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;

// FSM states
parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk) begin
	if (reset) begin
		state <= A;
		z <= 0;
	end else begin
		case(state)
			A: begin
				if (s == 1'b1) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
			B: begin
				if (w == 1'b1) begin
					state <= A;
					z <= 1;
				end else begin
					state <= B;
					z <= 0;
				end
			end
			default: state <= A;
		endcase
	end
end

endmodule
