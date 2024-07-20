module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	reg [2:0] state;
	reg [2:0] next_state;
	reg [2:0] count;
	reg [2:0] next_count;
	assign next_state = (reset) ? 3'b000 : state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
			count <= 3'b000;
		end else begin
			state <= next_state;
			count <= next_count;
		end
	end

	always @(*) begin
		case (state)
			3'b000: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
				if (in)
					next_count = count + 1'b1;
				else
					next_count = 3'b000;
				if (count == 3'b110)
					next_state = 3'b100;
				else if (in)
					next_state = 3'b001;
				else
					next_state = 3'b000;
			end
			3'b001: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
				next_count = count + 1'b1;
				if (count == 3'b110)
					next_state = 3'b100;
				else if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			end
			3'b010: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
				if (in)
					next_count = count + 1'b1;
				else
					next_count = 3'b000;
				if (count == 3'b110)
					next_state = 3'b100;
				else if (in)
					next_state = 3'b001;
				else
					next_state = 3'b000;
			end
			3'b011: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
				next_count = count + 1'b1;
				if (count == 3'b110)
					next_state = 3'b100;
				else if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			end
			3'b100: begin
				disc <= 1'b1;
				flag <= 1'b0;
				err <= 1'b0;
				if (in)
					next_state = 3'b001;
				else
					next_state = 3'b000;
				next_count = (in) ? 1'b1 : 3'b000;
			end
			3'b101: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b0;
				next_count = count + 1'b1;
				if (count == 3'b110)
					next_state = 3'b100;
				else if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			end
			3'b110: begin
				disc <= 1'b0;
				flag <= 1'b1;
				err <= 1'b0;
				next_count = count + 1'b1;
				if (count == 3'b110)
					next_state = 3'b100;
				else if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			end
			3'b111: begin
				disc <= 1'b0;
				flag <= 1'b0;
				err <= 1'b1;
				if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
				next_count = count + 1'b1;
			end
		endcase
	end

endmodule
