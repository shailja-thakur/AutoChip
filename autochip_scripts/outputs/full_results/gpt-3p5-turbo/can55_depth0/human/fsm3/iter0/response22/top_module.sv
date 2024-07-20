module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire out;

// state transition table
always @(posedge clk or negedge areset) begin
	if (areset == 0)
		state <= 2'b00;
	else if (state == 2'b00) begin
		if (in == 0)
			state <= 2'b00;
		else if (in == 1)
			state <= 2'b01;
	end else if (state == 2'b01) begin
		if (in == 0)
			state <= 2'b10;
		else if (in == 1)
			state <= 2'b01;
	end else if (state == 2'b10) begin
		if (in == 0)
			state <= 2'b00;
		else if (in == 1)
			state <= 2'b11;
	end else if (state == 2'b11) begin
		if (in == 0)
			state <= 2'b10;
		else if (in == 1)
			state <= 2'b01;
	end
end

// output logic
always @(state, in) begin
	case (state)
		2'b00: out = 1'b0;
		2'b01: out = 1'b0;
		2'b10: out = 1'b0;
		2'b11: out = 1'b1;
	endcase
end

endmodule
