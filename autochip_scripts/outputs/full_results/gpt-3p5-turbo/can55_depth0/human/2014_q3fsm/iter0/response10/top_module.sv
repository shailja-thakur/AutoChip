module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		state <= 2'b00;
		z <= 1'b0;
	end
	else begin
		state <= next_state;
		z <= (state == 2'b10);
	end
end

always @(state, w) begin
	case(state)
		2'b00: begin // State A
			if(s == 1'b1)
				next_state = 2'b01; // Move to State B
			else
				next_state = 2'b00; // Stay in State A
		end
		2'b01: begin // State B
			if(w == 1'b1)
				next_state = 2'b10; // Move to State C
			else
				next_state = 2'b01; // Stay in State B
		end
		2'b10: begin // State C
			if(w == 1'b1)
				next_state = 2'b10; // Stay in State C
			else
				next_state = 2'b11; // Move to State D
		end
		2'b11: begin // State D
			if(w == 1'b1)
				next_state = 2'b10; // Move back to State C
			else
				next_state = 2'b00; // Move to State A
		end
		default: next_state = 2'b00;
	endcase
end

endmodule
