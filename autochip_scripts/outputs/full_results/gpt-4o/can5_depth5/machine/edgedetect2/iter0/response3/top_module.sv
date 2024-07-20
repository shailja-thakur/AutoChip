module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] d_last;  // Register to store the previous value of 'in'

    always @(posedge clk) begin
        d_last <= in;                // Store current 'in' value in 'd_last'
        anyedge <= d_last ^ in;      // XOR current 'in' with 'd_last' to detect edges
    end

endmodule
