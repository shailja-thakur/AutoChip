module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// Parameters
parameter WIDTH = 8; // Bit-width of input and output

// Internal signals
reg [WIDTH-1:0] state; // State register
reg [WIDTH-1:0] x_reg; // Input register
reg [WIDTH-1:0] z_reg; // Output register

// State enum
localparam [2:0] S_IDLE = 3'b000;
localparam [2:0] S_CONVERT = 3'b001;
localparam [2:0] S_RESET = 3'b010;

// Input register assignment
always @(posedge clk or posedge areset) begin
	if (areset) begin
		x_reg <= 0;
	end else begin
		x_reg <= x;
	end
end

// Output register assignment
always @(posedge clk or posedge areset) begin
	if (areset) begin
		z_reg <= 0;
	end else begin
		case (state)
			S_IDLE:
				z_reg <= 0;
			S_CONVERT:
				z_reg <= ~x_reg + 1;
			S_RESET:
				z_reg <= 0;
		endcase
	end
end

// State transition and output logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= S_RESET;
	end else begin
		case (state)
			S_IDLE:
				if (x_reg != 0) begin
					state <= S_CONVERT;
				end
			S_CONVERT:
				state <= S_IDLE;
			S_RESET:
				state <= S_IDLE;
		endcase
	end
end

// Output assignment
assign z = z_reg;

endmodule
