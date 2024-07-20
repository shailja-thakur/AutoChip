module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg[1:0] state;
wire next_state;

assign out = (state == 2'b10);

always@(posedge clk or posedge areset)
	begin
		if(areset)
			state <= 2'b00;
		else
			state <= next_state;
	end

always@(*)
	begin
		case(state)
			2'b00: if(in) next_state = 2'b01; else next_state = 2'b00;
			2'b01: if(in) next_state = 2'b01; else next_state = 2'b10;
			2'b10: if(in) next_state = 2'b11; else next_state = 2'b00;
			2'b11: if(in) next_state = 2'b01; else next_state = 2'b10;
		endcase
	end

endmodule
