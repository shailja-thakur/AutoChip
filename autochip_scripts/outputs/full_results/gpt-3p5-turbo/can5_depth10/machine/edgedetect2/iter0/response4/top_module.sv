module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] d_last;

    always @(posedge clk) begin
        d_last <= in;
        if (in != d_last)
            anyedge <= 8'b1;
        else
            anyedge <= 8'b0;
    end
endmodule
