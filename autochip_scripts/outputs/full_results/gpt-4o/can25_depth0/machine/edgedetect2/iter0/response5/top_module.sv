module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] d_last;

    always @(posedge clk) begin
        d_last <= in; // Update the previous value of 'in'
        anyedge <= in ^ d_last; // XOR operation to detect any edge
    end

endmodule
