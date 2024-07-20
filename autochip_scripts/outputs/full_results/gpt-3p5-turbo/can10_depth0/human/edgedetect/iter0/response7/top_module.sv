module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_prev; // stores the previous input value

    always @(posedge clk) begin
        in_prev <= in; // store the current input value
        pedge <= (in & ~in_prev); // set the output bit when a 0 to 1 transition occurs
    end

endmodule
