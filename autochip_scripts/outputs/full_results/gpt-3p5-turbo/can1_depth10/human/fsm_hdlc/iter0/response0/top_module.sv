module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	wire [2:0] next_state;
	assign next_state = (reset) ? 3'b000 : state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			3'b000: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b0;
			end
			3'b001: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b0;
			end
			3'b010: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b0;
			end
			3'b011: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b0;
			end
			3'b100: begin
				disc = 1'b1;
				flag = 1'b0;
				err = 1'b0;
			end
			3'b101: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b0;
			end
			3'b110: begin
				disc = 1'b0;
				flag = 1'b1;
				err = 1'b0;
			end
			3'b111: begin
				disc = 1'b0;
				flag = 1'b0;
				err = 1'b1;
			end
		endcase
	end

endmodule
