module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Declare state register and output register
reg [2:0] state;
reg z_reg;

// Define state encoding
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// State transition and output logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
		z_reg <= 1'b0;
	end
	else begin
		case (state)
			A: begin
				if (w) state <= A;
				else state <= B;
			end
			B: begin
				if (w) state <= D;
				else state <= C;
			end
			C: begin
				if (w) state <= D;
				else state <= E;
			end
			D: begin
				if (w) state <= A;
				else state <= F;
			end
			E: begin
				if (w) state <= D;
				else state <= E;
			end
			F: begin
				if (w) state <= D;
				else state <= C;
			end
		endcase
	end
end

// Output assignment
always @(state) begin
	case (state)
		E: z_reg <= 1;
		default: z_reg <= 0;
	endcase
end

// Assign output wire
assign z = z_reg;

endmodule
