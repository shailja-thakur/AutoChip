module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] d_last;

    always @(posedge clk) begin
        d_last <= in; // update d_last with the current value of in
        anyedge <= (in ^ d_last) != 0; // calculate anyedge using XOR operation
    end
    
endmodule
