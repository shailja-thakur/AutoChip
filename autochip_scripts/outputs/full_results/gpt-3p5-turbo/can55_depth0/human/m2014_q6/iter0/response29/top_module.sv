module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// state register
reg [2:0] state;

// next state logic
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000;
	else if (w)
		case (state)
			3'b000: state <= 3'b100;
			3'b001: state <= 3'b011;
			3'b010: state <= 3'b101;
			3'b011: state <= 3'b110;
			3'b100: state <= 3'b010;
			3'b101: state <= 3'b110;
			3'b110: state <= 3'b001;
			3'b111: state <= 3'b101;
		endcase
	else
		case (state)
			3'b000: state <= 3'b001;
			3'b001: state <= 3'b000;
			3'b010: state <= 3'b011;
			3'b011: state <= 3'b110;
			3'b100: state <= 3'b000;
			3'b101: state <= 3'b111;
			3'b110: state <= 3'b100;
			3'b111: state <= 3'b110;
		endcase
end

// output logic
assign z = (state == 3'b010 || state == 3'b101 || state == 3'b111) ? 1'b1 : 1'b0;

endmodule
