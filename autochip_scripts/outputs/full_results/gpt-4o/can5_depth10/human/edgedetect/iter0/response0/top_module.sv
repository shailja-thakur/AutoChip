module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d;

    always @(posedge clk) begin
        in_d <= in;          // Register to store the previous value of 'in'
        pedge <= (~in_d) & in; // Positive edge detection
    end

endmodule
