module top_module (
    input clk,
    input areset,
    input x,
    output z
);
	// Mealy machine states
	reg [1:0] state, next_state;
	
	// Mealy machine outputs
	reg z_out;
	
	// State encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	
	// State transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
			z_out <= 0;
		end else begin
			state <= next_state;
			z_out <= (state == B && x) ? 0 : 1;
		end
	end
	
	// Next state logic
	always @(state or x) begin
		case (state)
			A: next_state = x ? B : A;
			B: next_state = x ? B : A;
		endcase
	end
	
	// Assign Mealy machine output to module output
	assign z = z_out;
	
endmodule
