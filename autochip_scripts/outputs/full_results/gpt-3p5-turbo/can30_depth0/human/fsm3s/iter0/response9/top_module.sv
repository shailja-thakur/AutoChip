module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define the states as parameters
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the state register and next state
reg [1:0] state_reg;
reg [1:0] state_next;

// Define the output register
reg out_reg;

// Define the outputs
assign out = out_reg;

// State transition and output logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= A;
		out_reg <= 1'b0;
	end else begin
		state_reg <= state_next;
		out_reg <= (state_reg == D) ? 1'b1 : 1'b0;
	end
end

// Next state logic
always @(*) begin
	case (state_reg)
		A: begin
			state_next = in ? B : A;
		end
		B: begin
			state_next = in ? B : C;
		end
		C: begin
			state_next = in ? D : A;
		end
		D: begin
			state_next = in ? B : C;
		end
	endcase
end

endmodule
