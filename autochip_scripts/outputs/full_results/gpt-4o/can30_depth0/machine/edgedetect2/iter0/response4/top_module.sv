module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] d_last; // Register to store the previous value of in signal

    always @(posedge clk) begin
        anyedge <= in ^ d_last; // Calculate edges
        d_last <= in; // Update the register with the current value of in signal
    end
endmodule
