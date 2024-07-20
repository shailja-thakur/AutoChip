module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // register to store delayed in

    always @(posedge clk) begin
        in_d <= in;       // store the current input in the delay register
        pedge <= in & ~in_d; // detect rising edge for each bit
    end

endmodule
