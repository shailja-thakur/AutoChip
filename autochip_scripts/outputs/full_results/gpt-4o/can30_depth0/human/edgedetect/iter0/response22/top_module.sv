module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // Register to store the previous state of 'in'

    always @(posedge clk) begin
        pedge <= (~in_d & in); // Detect positive edge
        in_d <= in; // Update the previous state
    end

endmodule
