module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    reg q_temp;

    always @(*)
    begin
        case ({a, b, c, d})
            4'b0000: q_temp = 1'b0;
            4'b0001: q_temp = 1'b0;
            4'b0010: q_temp = b;
            4'b0011: q_temp = b;
            4'b0100: q_temp = a;
            4'b0101: q_temp = 1'b1;
            4'b0110: q_temp = 1'b1;
            4'b0111: q_temp = 1'b1;
            4'b1000: q_temp = 1'b0;
            4'b1001: q_temp = 1'b0;
            4'b1010: q_temp = b;
            4'b1011: q_temp = b;
            4'b1100: q_temp = a;
            4'b1101: q_temp = 1'b1;
            4'b1110: q_temp = a;
            4'b1111: q_temp = 1'b1;
        endcase
    end

    assign q = q_temp;

endmodule
