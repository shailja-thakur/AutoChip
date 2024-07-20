module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire next_state;
reg out;

always @(posedge clk, posedge areset)
begin
	if(areset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @*
begin
	case(state)
		2'b00: // B
		begin
			if(in)
				next_state = 2'b01; // A
			else
				next_state = 2'b00; // B
		end
		
		2'b01: // A
		begin
			if(in)
				next_state = 2'b01; // A
			else
				next_state = 2'b00; // B
		end
	endcase
end

always @(posedge clk)
begin
	if(areset)
		out <= 1'b0;
	else if(state == 2'b00) // B
		out <= 1'b1;
	else if(state == 2'b01) // A
		out <= 1'b0;
end

endmodule
