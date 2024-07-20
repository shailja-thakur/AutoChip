module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	reg [2:0] state;
	reg [2:0] count;
	reg [2:0] next_count;
	reg [2:0] next_state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
			count <= 3'b000;
		end else begin
			state <= next_state;
			count <= next_count;
		end
	end

	always @* begin
		case (state)
			3'b000: begin
				if (in)
					next_count = count + 1'b1;
				else
					next_count = 3'b000;
				if (count == 3'b101)
					next_state = 3'b100;
				else if (in)
					next_state = 3'b001;
				else
					next_state = 3'b000;
			end
			3'b001: begin
				next_count = count + 1'b1;
				if (count == 3'b101)
					next_state = 3'b100;
				else if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			end
			3'b010: begin
				if (in)
					next_count = count + 1'b1;
				else
					next_count = 3'b000;
				if (count == 3'b101)
					next_state = 3'b100;
				else if (in)
					next_state = 3'b001;
				else
					next_state = 3'b000;
			end
			3'b011: begin
				next_count = count + 1'b1;
				if (count == 3'b101)
					next_state = 3'b100;
				else if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			end
			3'b100: begin
				next_state = (in) ? 3'b001 : 3'b000;
				next_count = (in) ? 1'b1 : 3'b000;
			end
			3'b101: begin
				next_count = count + 1'b1;
				if (count == 3'b101)
					next_state = 3'b100;
				else if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			end
			3'b110: begin
				next_count = count + 1'b1;
				if (count == 3'b101)
					next_state = 3'b100;
				else if (!in)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			end
			3'b111: begin
				next_state = (!in) ? 3'b010 : 3'b001;
				next_count = count + 1'b1;
			end
		endcase
	end

	always @(posedge clk) begin
		if (reset)
			disc <= 1'b0;
		else if (state == 3'b100)
			disc <= 1'b1;
		else
			disc <= 1'b0;
	end

	always @(posedge clk) begin
		if (reset)
			flag <= 1'b0;
		else if (state == 3'b101)
			flag <= 1'b1;
		else
			flag <= 1'b0;
	end

	always @(posedge clk) begin
		if (reset)
			err <= 1'b0;
		else if (state == 3'b111)
			err <= 1'b1;
		else
			err <= 1'b0;
	end

endmodule
