module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

// Define the next state for each present state and input combination
always @(posedge clk) begin
    case({y, x})
        3'b000_0: Y0 <= 1'b0; // Next state = 000, Y0 = 0
        3'b000_1: Y0 <= 1'b0; // Next state = 001, Y0 = 0
        3'b001_0: Y0 <= 1'b0; // Next state = 010, Y0 = 0
        3'b001_1: Y0 <= 1'b0; // Next state = 100, Y0 = 0
        3'b010_0: Y0 <= 1'b0; // Next state = 010, Y0 = 0
        3'b010_1: Y0 <= 1'b0; // Next state = 001, Y0 = 0
        3'b011_0: Y0 <= 1'b0; // Next state = 001, Y0 = 0
        3'b011_1: Y0 <= 1'b0; // Next state = 010, Y0 = 0
        3'b100_0: Y0 <= 1'b1; // Next state = 011, Y0 = 1
        3'b100_1: Y0 <= 1'b0; // Next state = 100, Y0 = 1
        default: Y0 <= 1'b0; // Default next state = 000, Y0 = 0
    endcase

    // Output z logic function
    if ({y, x} == 3'b011_0) // Present state = 011, x = 0
        z <= 1'b1;
    else if ({y, x} == 3'b100_0) // Present state = 100, x = 0
        z <= 1'b1;
    else
        z <= 1'b0;
end
endmodule
