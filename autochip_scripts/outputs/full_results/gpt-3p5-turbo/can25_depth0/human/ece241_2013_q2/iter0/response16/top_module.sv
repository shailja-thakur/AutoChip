module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire [3:0] num;

    assign num = {a, b, c, d};

    assign out_sop = (num == 4'b0010) || (num == 4'b0111) || (num == 4'b1111);
    assign out_pos = (num != 4'b0000) && (num != 4'b0001) && (num != 4'b0100) && (num != 4'b0101) && (num != 4'b0110) && (num != 4'b1001) && (num != 4'b1010) && (num != 4'b1101) && (num != 4'b1110);

endmodule
