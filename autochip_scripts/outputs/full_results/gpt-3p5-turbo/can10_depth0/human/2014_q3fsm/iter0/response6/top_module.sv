module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define states
parameter A = 2'b00;   // Reset state
parameter B = 2'b01;   // State B

// Define state register
reg [1:0] state;

// Output z logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
		z <= 0;
	end else begin
		case (state)
			A: begin
				if (s == 1)
					state <= B;
				else
					state <= A;
			end
			B: begin
				if ((w == 1) && (w == 1))
					z <= 1;
				else
					z <= 0;

				state <= A;
			end
		endcase
	end
end

endmodule
