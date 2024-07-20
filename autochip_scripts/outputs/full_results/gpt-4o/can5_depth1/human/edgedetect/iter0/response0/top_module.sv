module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // Register to hold the delayed version of 'in'

    always @(posedge clk) begin
        in_d <= in;       // Update delayed version of 'in' at every clk edge
        pedge <= ~in_d & in; // Check for positive edge and set pedge output accordingly
    end

endmodule
