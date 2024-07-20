module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] d_last;

    always @(posedge clk) begin
        d_last <= in;  // update d_last with the current value of in
    end

    always @(posedge clk) begin
        anyedge <= in ^ d_last;  // calculate anyedge as the XOR of in and d_last
    end

endmodule
