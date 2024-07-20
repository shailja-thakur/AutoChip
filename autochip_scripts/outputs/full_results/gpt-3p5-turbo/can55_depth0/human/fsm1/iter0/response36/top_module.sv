module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire next_state;

// State B
parameter B = 2'b00;
assign next_state = (areset) ? B : 

	// State A
	// (in && !areset) will be 1'b0 in the following state transitions
	(in) ? B :
	(!in && !areset) ? B :

	// State B
	(in && !areset) ? A :

	// State A
	(in && !areset) ? A :
	(!in && !areset) ? B :
	;
	
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= B;
	else
		state <= next_state;
end

assign out = (state == A) ? 1'b1 : 1'b0;

endmodule
