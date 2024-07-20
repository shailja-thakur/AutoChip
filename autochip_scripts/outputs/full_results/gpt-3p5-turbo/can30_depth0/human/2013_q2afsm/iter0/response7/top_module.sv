module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	
	// State codes
	localparam A = 3'b000;
	localparam B = 3'b001;
	localparam C = 3'b010;
	localparam D = 3'b011;
	
	// Registers
	reg [2:0] state_reg;
	reg [3:1] grant_reg;
	
	// State table
	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			state_reg <= A;
		else
		begin
			case (state_reg)
				A: if (r[1])
						state_reg <= B;
				   else if (r[2])
						state_reg <= C;
				   else if (r[3])
						state_reg <= D;
				   else
						state_reg <= A;
				B: if (r[1])
						state_reg <= B;
				   else
						state_reg <= A;
				C: if (r[2])
						state_reg <= C;
				   else
						state_reg <= A;
				D: if (r[1])
						state_reg <= A;
				   else if (r[2])
						state_reg <= A;
				   else if (r[3])
						state_reg <= A;
				   else
						state_reg <= D;
			endcase
		end
	end
	
	// State flip-flops
	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			grant_reg <= 3'b000;
		else
		begin
			case (state_reg)
				A: grant_reg <= 3'b000;
				B: if (r[1])
						grant_reg <= 3'b001;
				   else
						grant_reg <= 3'b000;
				C: if (r[2])
						grant_reg <= 3'b010;
				   else
						grant_reg <= 3'b000;
				D: grant_reg <= 3'b000;
			endcase
		end
	end
	
	// Assign FSM outputs
	assign g = grant_reg;
	
endmodule
