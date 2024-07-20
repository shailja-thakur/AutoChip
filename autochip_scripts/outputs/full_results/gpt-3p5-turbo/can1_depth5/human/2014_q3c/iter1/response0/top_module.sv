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
        3'b0000_0: Y0 <= 1'b0; // Add extra 0
        3'b0000_1: Y0 <= 1'b0; // Add extra 0
        3'b0010_0: Y0 <= 1'b0; // Add extra 0
        3'b0010_1: Y0 <= 1'b0; // Add extra 0
        3'b0100_0: Y0 <= 1'b0; // Add extra 0
        3'b0100_1: Y0 <= 1'b0; // Add extra 0
        3'b0110_0: Y0 <= 1'b0; // Add extra 0
        3'b0110_1: Y0 <= 1'b0; // Add extra 0
        3'b1000_0: Y0 <= 1'b1; // Add extra 0
        3'b1000_1: Y0 <= 1'b0; // Add extra 0
        default: Y0 <= 1'b0;
    endcase

    // Output z logic function
    if ({y, x} == 3'b0110_0) // Fix present state and input combination
        z <= 1'b1;
    else if ({y, x} == 3'b1000_0) // Fix present state and input combination
        z <= 1'b1;
    else
        z <= 1'b0;
end
endmodule
