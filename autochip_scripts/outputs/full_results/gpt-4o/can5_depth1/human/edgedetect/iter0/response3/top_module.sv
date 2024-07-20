module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d;

    always @(posedge clk) begin
        in_d <= in;          // Register to hold the previous state of 'in'
        pedge <= in & ~in_d; // Output 'pedge' is '1' when 'in' changes from 0 to 1
    end

endmodule
