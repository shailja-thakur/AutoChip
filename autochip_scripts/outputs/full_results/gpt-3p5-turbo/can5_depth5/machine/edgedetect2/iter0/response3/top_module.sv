module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] d_last; // register to store the previous value of the in signal

    always @(posedge clk) begin
        d_last <= in; // update d_last register with current value of in signal
        anyedge <= in ^ d_last; // XOR operation to detect edge
    end

endmodule
