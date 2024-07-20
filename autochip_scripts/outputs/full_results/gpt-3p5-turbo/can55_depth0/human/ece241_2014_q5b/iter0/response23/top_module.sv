module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z_next;

// State declaration
parameter A = 2'b00;
parameter B = 2'b01;

// Output assignment
assign z = z_next;

// State transitions and output assignments
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else 
		case(state)
			A: begin
				   if (x)
					   state <= B;
				   else
					   state <= A;
			   end
			B: begin
				   if (x)
					   state <= B;
				   else
					   state <= B;
			   end
		endcase
	end

// Output assignments
always @(state, x) begin
	case(state)
		A: begin
			   if (x)
				   z_next = 1;
			   else
				   z_next = 0;
		   end
		B: begin
			   if (x)
				   z_next = 0;
			   else
				   z_next = 1;
		   end
	endcase
end

endmodule
