module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;
reg out;

// Define states
parameter B = 2'b00;
parameter A = 2'b01;

// State transitions and outputs
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= B;
		out <= 1;
	end else begin
		state <= next_state;
		
		case (state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 1;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
				out = 0;
			end
		endcase
	end
end

endmodule
