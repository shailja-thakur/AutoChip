module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);
	reg [3:0] next_state_temp;
	
	always @* begin
		case (state)
			4'b0001: next_state_temp = in ? 4'b0010 : 4'b0001;
			4'b0010: next_state_temp = in ? 4'b0010 : 4'b0100;
			4'b0100: next_state_temp = in ? 4'b0001 : 4'b1000;
			4'b1000: next_state_temp = in ? 4'b0100 : 4'b0010;
			default: next_state_temp = 4'b0000;
		endcase
	end
	
	assign next_state = next_state_temp;
	assign out = (state == 4'b1000) ? 1'b1 : 1'b0;
	
endmodule
