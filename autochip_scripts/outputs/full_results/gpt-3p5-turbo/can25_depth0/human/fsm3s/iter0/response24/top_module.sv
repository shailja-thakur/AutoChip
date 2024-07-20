module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state, next_state;
reg out;
	
// State definitions
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
	
// Output definitions
parameter OUTPUT_0 = 1'b0;
parameter OUTPUT_1 = 1'b1;
	
// State transition and output logic
always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
		out <= OUTPUT_0;
	end else begin
		state <= next_state;
		out <= (state == D) ? OUTPUT_1 : OUTPUT_0;
	end
end
	
// Next state logic
always @* begin
	case (state)
		A: next_state = (in) ? B : A;
		B: next_state = (in) ? B : C;
		C: next_state = (in) ? D : A;
		D: next_state = (in) ? B : C;
	endcase
end

endmodule
