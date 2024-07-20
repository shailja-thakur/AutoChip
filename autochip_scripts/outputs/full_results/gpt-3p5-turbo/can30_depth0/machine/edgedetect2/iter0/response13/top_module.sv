module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] d_last; // register to store previous value of in signal

    always @(posedge clk) begin
        d_last <= in; // updating d_last with current value of in signal
        anyedge <= in ^ d_last; // performing XOR operation to detect edge
    end
endmodule
