module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	reg out1;
	reg out2;
	reg [9:0] next_state_reg;

	always @* begin
		case (state)
			10'b0000000001: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0000000001;
			end
			10'b0000000010: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0000000100;
			end
			10'b0000000100: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0000000001;
			end
			10'b0000001000: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0000010000;
			end
			10'b0000010000: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0000000001;
			end
			10'b0000100000: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0010000000;
			end
			10'b0001000000: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0000000001;
			end
			10'b0010000000: begin
				out1 = 1'b1;
				out2 = 1'b0;
				next_state_reg = 10'b0000000100;
			end
			10'b0100000000: begin
				out1 = 1'b0;
				out2 = 1'b1;
				next_state_reg = 10'b0000000001;
			end
			10'b1000000000: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0000000010;
			end
			default: begin
				out1 = 1'b0;
				out2 = 1'b0;
				next_state_reg = 10'b0000000001;
			end
		endcase
	end

	always @(posedge clk) begin
		next_state <= next_state_reg;
	end

endmodule
