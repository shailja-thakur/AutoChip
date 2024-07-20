module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		state <= 2'b00;
		done <= 1'b0;
	end else begin
		state <= next_state;
		done <= 1'b0;
	end
end

always @(state, in) begin
	case(state)
		2'b00: begin
			if(in[3] == 1'b1) begin
				next_state = 2'b01;
			end else begin
				next_state = 2'b00;
			end
		end

		2'b01: begin
			if(in[3] == 1'b1) begin
				next_state = 2'b10;
			end else begin
				next_state = 2'b00;
			end
		end

		2'b10: begin
			if(in[3] == 1'b1) begin
				next_state = 2'b11;
			end else begin
				next_state = 2'b00;
				done = 1'b1;
			end
		end

		2'b11: begin
			next_state = 2'b00;
		end
	endcase
end

endmodule
