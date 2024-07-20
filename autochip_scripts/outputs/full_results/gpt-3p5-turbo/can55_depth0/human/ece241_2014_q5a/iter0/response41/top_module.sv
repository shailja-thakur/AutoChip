module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	// Define states
	typedef enum logic [1:0] {S0, S1} state_type;
	state_type state, next_state;

	// Define flip-flops
	reg z_reg;

	// Define input and output wires
	wire x_in, z_out;

	// Register for input x
	reg [7:0] x_reg;

	// Initialize states
	initial begin
		state = S0;
	end

	// Synchronous process
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
			x_reg <= 8'b0;
			z_reg <= 1'b0;
		end else begin
			state <= next_state;
			x_reg <= {x_reg[6:0], x};
			z_reg <= z_out;
		end
	end

	// Combinational process
	always @(*) begin
		case (state)
			S0: begin
				next_state = S1;
				x_in = x_reg[7];
				z_out = ~x_reg[7];
			end
			S1: begin
				next_state = S0;
				x_in = x_reg[7];
				z_out = x_reg[7];
			end
		endcase
	end

	// Assign outputs
	assign z = z_reg;

endmodule
