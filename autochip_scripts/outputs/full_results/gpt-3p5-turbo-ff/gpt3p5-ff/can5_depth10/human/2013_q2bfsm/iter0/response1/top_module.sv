module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	// Registers
	reg [1:0] state;
	reg f_reg;
	reg g_reg;
	reg [2:0] x_reg;
	reg y_flag;
	reg [1:0] counter;

	// State parameters
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;

	// Assign initial state
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= state;
	end

	// FSM logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
			f_reg <= 0;
			g_reg <= 0;
			x_reg <= 3'b000;
		end else begin
			case (state)
				A: begin
					if (resetn)
						state <= B;
				end
				B: begin
					state <= C;
					f_reg <= 1;
					counter <= 0;
				end
				C: begin
					if (x_reg == 3'b101) begin
						state <= D;
						g_reg <= 1;
						counter <= 0;
					end else begin
						state <= C;
						counter <= counter + 1;
						x_reg <= {x_reg[1:0], x};
					end
				end
				D: begin
					if (y == 1 && counter <= 2) begin
						state <= D;
					end else if (y == 1 && counter > 2) begin
						state <= D;
						counter <= 0;
					end else begin
						state <= A;
						g_reg <= 0;
						counter <= 0;
					end
				end
			endcase
		end
	end

	// Assign outputs
	assign f = f_reg;
	assign g = g_reg;
endmodule
