module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [31:0] state;
	reg [31:0] next_state;
	reg [31:0] x_reg;
	reg [31:0] z_reg;
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or x_reg) begin
		case (state)
			S0: begin
				if (x) begin
					next_state <= S1;
				end else begin
					next_state <= S0;
				end
				x_reg <= x;
				z_reg <= x;
			end
			S1: begin
				if (~x) begin
					next_state <= S1;
				end else begin
					next_state <= S2;
				end
				x_reg <= x;
				z_reg <= ~x_reg + 1;
			end
			S2: begin
				if (x) begin
					next_state <= S2;
				end else begin
					next_state <= S2;
				end
				x_reg <= x;
				z_reg <= ~x_reg + 1;
			end
		endcase
	end
	
	assign z = z_reg;
	
endmodule
