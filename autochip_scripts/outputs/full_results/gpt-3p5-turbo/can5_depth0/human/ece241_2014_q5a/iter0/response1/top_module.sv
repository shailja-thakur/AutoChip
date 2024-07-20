module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [31:0] sum;  // variable to hold the sum

// states
reg [1:0] state, next_state;

// state parameters
parameter IDLE = 2'b00;
parameter ADDITIVE = 2'b01;
parameter COMPLEMENT = 2'b10;

// inputs and output
reg x_reg;
wire x_not;

// assign x_not as complement of x
assign x_not = ~x_reg;

// sequential logic
always @(posedge clk, posedge areset)
begin
	if (areset)
		state <= IDLE;
	else
		state <= next_state;
end

// combinational logic
always @*
begin
	case (state)
		IDLE:
			begin
				if (areset)
					next_state = IDLE;
				else if (x_reg == 1'b1)
					next_state = ADDITIVE;
				else
					next_state = IDLE;
			end

		ADDITIVE:
			begin
				if (areset)
					next_state = IDLE;
				else
					next_state = COMPLEMENT;
			end

		COMPLEMENT:
			begin
				if (areset)
					next_state = IDLE;
				else
					next_state = ADDITIVE;
			end
	endcase
end

// output logic
always @*
begin
	case (state)
		IDLE:
			begin
				if (areset)
					z = 1'b0;  // when reset asserted, output is 0
				else
					z = sum[0];  // output is the LSB of the sum
			end

		ADDITIVE:
			begin
				if (areset)
					z = 1'b0;  // when reset asserted, output is 0
				else
					z = sum[0];  // output is the LSB of the sum
			end

		COMPLEMENT:
			begin
				z = x_not;
			end
	endcase
end

// register for storing input x
always @(posedge clk, posedge areset)
begin
	if (areset)
		x_reg <= 1'b0;
	else
		x_reg <= x;
end

// adder logic
always @(posedge clk, posedge areset)
begin
	if (areset)
		sum <= 0;
	else if (state == ADDITIVE)
		sum <= sum + x_reg;
	else if (state == COMPLEMENT)
		sum <= sum - x_reg;
end

endmodule
