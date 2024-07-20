module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] d_last;

    always @(posedge clk) begin
        // Calculate pedge as the bitwise AND of 'in' and the inverse of 'd_last'
        pedge <= in & ~d_last;
        // Update d_last with the current value of 'in'
        d_last <= in;
    end

endmodule
