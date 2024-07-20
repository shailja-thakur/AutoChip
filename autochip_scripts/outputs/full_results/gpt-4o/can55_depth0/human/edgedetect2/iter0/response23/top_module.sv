module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] in_d; // Register to store the previous state of the input

    always @(posedge clk) begin
        in_d <= in; // Store the current input value to compare in the next clock cycle
        anyedge <= (in & ~in_d); // Detect rising edge and set the corresponding bit
    end

endmodule
