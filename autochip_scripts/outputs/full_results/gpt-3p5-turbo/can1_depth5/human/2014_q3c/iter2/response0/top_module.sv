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
        3'b0000: Y0 <= 1'b0; 
        3'b0001: Y0 <= 1'b0; 
        3'b0010: Y0 <= 1'b0; 
        3'b0011: Y0 <= 1'b0; 
        3'b0100: Y0 <= 1'b0; 
        3'b0101: Y0 <= 1'b0; 
        3'b0110: Y0 <= 1'b0; 
        3'b1000: Y0 <= 1'b1; 
        default: Y0 <= 1'b0;
    endcase

    // Output z logic function
    if ({y, x} == 3'b0110)
        z <= 1'b1;
    else if ({y, x} == 3'b1000)
        z <= 1'b1;
    else
        z <= 1'b0;
end
endmodule
