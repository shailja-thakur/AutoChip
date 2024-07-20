module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in; // store current 'in' to prev_in on positive edge of clock
        pedge <= in & ~prev_in; // detect 0 to 1 transition
    end

endmodule
