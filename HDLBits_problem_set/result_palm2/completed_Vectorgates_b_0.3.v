module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    always @(posedge clk) begin
        out_or_bitwise <= a | b;
        out_or_logical <= a or b;
        out_not[5:3] <= ~b;
        out_not[2:0] <= ~a;
    end

endmodule