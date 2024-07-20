module top_module(
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_reg; // Create a register to hold the output values

    always @(posedge clk)
        q_reg <= d; // Assign the input value to the register on the positive edge of the clock

    always @*
        q = q_reg; // Assign the value of the register to the output

endmodule
