module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset)
begin
	if (reset)
		state <= 3'b000;
	else
		state <= next_state;
end

always @(*)
begin
	case(state)
		3'b000: if(w) next_state = 3'b001; else next_state = 3'b010;
		3'b001: if(w) next_state = 3'b011; else next_state = 3'b000;
		3'b010: if(w) next_state = 3'b101; else next_state = 3'b010;
		3'b011: if(w) next_state = 3'b110; else next_state = 3'b001;
		3'b100: if(w) next_state = 3'b100; else next_state = 3'b010;
		3'b101: if(w) next_state = 3'b110; else next_state = 3'b010;
		3'b110: if(w) next_state = 3'b011; else next_state = 3'b100;
		3'b111: if(w) next_state = 3'b010; else next_state = 3'b001;
		default: next_state = 3'b000;
	endcase
end

always @(*)
begin
	case(state)
		3'b000: z = 1'b0;
		3'b001: z = 1'b0;
		3'b010: z = 1'b0;
		3'b011: z = 1'b0;
		3'b100: z = 1'b0;
		3'b101: z = 1'b0;
		3'b110: z = 1'b0;
		3'b111: z = 1'b1;
		default: z = 1'b0;
	endcase
end

endmodule
