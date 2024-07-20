module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Declare state register
	reg [1:0] state;

	// Declare output register
	reg z_reg;

	// Declare next state and z values
	reg [1:0] next_state;
	reg next_z;

	// Define state encoding
	parameter A = 2'b00;
	parameter B = 2'b01;

	// State transition and output logic
	always @ (posedge clk or posedge areset)
	begin
		if (areset)
		begin
			state <= A;
			z_reg <= 1'b0;
		end
		else
		begin
			state <= next_state;
			z_reg <= next_z;
		end
	end

	// Next state and output values logic
	always @ (state or x)
	begin
		case (state)
			A:
				begin
					if (x)
					begin
						next_state = B;
						next_z = 1'b1;
					end
					else
					begin
						next_state = A;
						next_z = 1'b0;
					end
				end

			B:
				begin
					if (x)
					begin
						next_state = B;
						next_z = 1'b0;
					end
					else
					begin
						next_state = B;
						next_z = 1'b1;
					end
				end

			default:
				begin
					next_state = A;
					next_z = 1'b0;
				end
		endcase
	end

	// Assign output
	assign z = z_reg;

endmodule
