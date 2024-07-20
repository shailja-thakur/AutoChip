module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // Register to store the delayed version of the input

    always @(posedge clk) begin
        in_d <= in; // Store the previous cycle's input value
        pedge <= ~in_d & in; // Detect positive edge by comparing current and previous input values
    end

endmodule
