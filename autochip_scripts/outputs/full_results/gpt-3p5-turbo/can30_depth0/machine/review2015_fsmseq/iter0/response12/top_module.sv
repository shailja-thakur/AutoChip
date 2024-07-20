module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

reg [2:0] state;
wire output;

// Combinational logic to determine next state
always @(state or data) begin
	case (state)
		S: begin
			if (data) state = S1;
			else state = S;
		end
		S1: begin
			if (data) state = S11;
			else state = S;
		end
		S11: begin
			if (data) state = S11;
			else state = S110;
		end
		S110: begin
			if (data) state = Done;
			else state = S;
		end
		Done: state = Done;
	endcase
end

// Output assignment
assign start_shifting = (state == Done) ? 1'b1 : 1'b0;

// State machine update and reset
always @(posedge clk or posedge reset) begin
	if (reset) state <= S;
	else state <= state;
end

endmodule
