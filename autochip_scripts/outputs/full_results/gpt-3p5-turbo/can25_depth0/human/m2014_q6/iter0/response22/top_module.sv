module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
wire [1:0] inputs;
assign inputs = {state[1], w};

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000;
	else begin
		case (state)
			3'b000: state <= (inputs == 2'b00) ? 3'b100 : 3'b000;
			3'b001: state <= (inputs == 2'b01) ? 3'b101 : 3'b001;
			3'b010: state <= (inputs == 2'b00) ? 3'b011 : 3'b010;
			3'b011: state <= (inputs == 2'b01) ? 3'b101 : 3'b011;
			3'b100: state <= (inputs == 2'b00) ? 3'b110 : 3'b100;
			3'b101: state <= (inputs == 2'b01) ? 3'b011 : 3'b101;
			3'b110: state <= (inputs == 2'b00) ? 3'b010 : 3'b110;
			3'b111: state <= (inputs == 2'b01) ? 3'b011 : 3'b000;
		endcase
	end
end

always @(state) begin
	case (state)
		3'b000: z <= 1'b1;
		3'b001: z <= 1'b0;
		3'b010: z <= 1'b0;
		3'b011: z <= 1'b0;
		3'b100: z <= 1'b0;
		3'b101: z <= 1'b0;
		3'b110: z <= 1'b0;
		3'b111: z <= 1'b0;
	endcase
end

endmodule
