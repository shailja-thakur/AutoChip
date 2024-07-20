module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

// State variables
reg state;
parameter A = 1'b0, B = 1'b1;

// Next state logic
always @(*) begin
	case (state)
		A: begin
			if (in == 1'b0) begin
				state <= B;
			end else begin
				state <= A;
			end
		end
		B: begin
			if (in == 1'b0) begin
				state <= B;
			end else begin
				state <= A;
			end
		end
		default: begin
			state <= B; // Asynchronous reset to state B
		end
	endcase
end

// Output logic
always @(*) begin
	case (state)
		A: out = 1'b0;
		B: out = 1'b1;
		default: out = 1'b0;
	endcase
end

// State update
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= B; // Asynchronous reset to state B
	end else begin
		state <= state;
	end
end

endmodule
