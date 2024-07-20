module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;

// Define output values
parameter OUTPUT_0 = 0;
parameter OUTPUT_1 = 1;

// Define state register and next state
reg [1:0] state_reg;
wire [1:0] state_next;

// Define output register
reg out_reg;

// Assign next state logic
always @ (posedge clk) begin
	if (reset) begin
		state_reg <= A;
	end else begin
		state_reg <= state_next;
	end
end

// Define state transition logic
always @ (*) begin
	case (state_reg)
		A: begin
			if (in) begin
				state_next = B;
			end else begin
				state_next = A;
			end
			out_reg = OUTPUT_0;
		end
		B: begin
			if (in) begin
				state_next = B;
			end else begin
				state_next = C;
			end
			out_reg = OUTPUT_0;
		end
		C: begin
			if (in) begin
				state_next = D;
			end else begin
				state_next = A;
			end
			out_reg = OUTPUT_0;
		end
		D: begin
			if (in) begin
				state_next = B;
			end else begin
				state_next = C;
			end
			out_reg = OUTPUT_1;
		end
		default: begin
			state_next = A;
			out_reg = OUTPUT_0;
		end
	endcase
end

// Assign output
assign out = out_reg;

endmodule
