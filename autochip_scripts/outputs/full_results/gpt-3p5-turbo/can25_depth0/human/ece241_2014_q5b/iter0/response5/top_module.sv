module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
wire out;

// State encoding
parameter A = 2'b00;
parameter B = 2'b01;

// Transition logic
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end

// Next state and output logic
always @(*)
begin
	case (state)
		A: begin
			if (x == 1'b0)
			begin
				next_state = A;
				out = 1'b0;
			end
			else
			begin
				next_state = B;
				out = 1'b1;
			end
		end
		
		B: begin
			if (x == 1'b0)
			begin
				next_state = B;
				out = 1'b1;
			end
			else
			begin
				next_state = B;
				out = 1'b0;
			end
		end
	endcase
end

// Output assignment
assign z = out;

endmodule
