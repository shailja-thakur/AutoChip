module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg [2:0] next_state;
reg z_reg;
wire z;

// State definitions
parameter reset = 3'b000;
parameter convert = 3'b001;
parameter stop = 3'b010;

// Next State Logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= reset;
	end else begin
		state <= next_state;
	end
end

// Output Logic
always @(state or x) begin
	case (state)
		reset: begin
			z_reg <= 0;
			next_state <= convert;
		end
		convert: begin
			z_reg <= ~x;
			if (x == 1) begin
				next_state <= stop;
			else begin
				next_state <= convert;
			end
		end
		stop: begin
			next_state <= reset;
		end
	endcase
end

assign z = z_reg;

endmodule
