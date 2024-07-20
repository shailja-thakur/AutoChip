module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;  // Initial state is A
		else begin
			case (state)
				3'b000: state <= w ? 3'b001 : 3'b000;  // A -> B or A->A
				3'b001: state <= w ? 3'b010 : 3'b010;  // B -> C or B->D
				3'b010: state <= w ? 3'b100 : 3'b011;  // C -> E or C->D
				3'b011: state <= w ? 3'b011 : 3'b000;  // D -> F or D->A
				3'b100: state <= w ? 3'b100 : 3'b100;  // E -> E or E->D
				3'b101: state <= w ? 3'b010 : 3'b001;  // F -> C or F->B
			endcase
	  end
	end
	
	assign z = (state == 3'b100) || (state == 3'b101);  // Set z to 1 when in state E or F
	
endmodule
