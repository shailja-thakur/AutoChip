module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
	if (!resetn) begin
		state <= 2'b00; // Initialize state to A
	end
	else begin
		state <= next;
	end
end

always @* begin
	case (state)
		2'b00: begin // State A
			if (r[2]) begin
				next = 2'b10; // next state is C
			end
			else if (r[1]) begin
				next = 2'b01; // next state is B
			end
			else if (r[0]) begin
				next = 2'b11; // next state is D
			end
			else begin
				next = 2'b00; // next state is A
			end
		end

		2'b01: begin // State B
			if (r[1]) begin
				next = 2'b01; // next state is B
			end
			else begin
				next = 2'b00; // next state is A
			end
		end

		2'b10: begin // State C
			if (r[2]) begin
				next = 2'b10; // next state is C
			end
			else begin
				next = 2'b00; // next state is A
			end
		end

		2'b11: begin // State D
			if (r[0]) begin
				next = 2'b11; // next state is D
			end
			else begin
				next = 2'b00; // next state is A
			end
		end
	end
end

always @* begin
	if (state == 2'b01) begin
		g[2] = 1'b0;
		g[1] = 1'b1;
		g[0] = 1'b0;
	end
	else if (state == 2'b10) begin
		g[2] = 1'b1;
		g[1] = 1'b0;
		g[0] = 1'b0;
	end
	else if (state == 2'b11) begin
		g[2] = 1'b0;
		g[1] = 1'b0;
		g[0] = 1'b1;
	end
	else begin
		g[2] = 1'b0;
		g[1] = 1'b0;
		g[0] = 1'b0;
	end
end

endmodule
