module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] d_last;

    always @(posedge clk) begin
        d_last <= in;  // Update d_last with current value of in signal
        anyedge <= (in ^ d_last) ? 1 : 0;  // Perform XOR operation to detect edge
    end

endmodule
