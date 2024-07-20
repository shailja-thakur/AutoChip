module top_module(
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_reg;  // create a separate register to store the output value temporarily

    always @(posedge clk)
        q_reg <= d;  // assign the input value to the temporary register on the positive edge of the clock

    always @(posedge clk)
        q <= q_reg;  // assign the value of the temporary register to the output on the positive edge of the clock

endmodule
