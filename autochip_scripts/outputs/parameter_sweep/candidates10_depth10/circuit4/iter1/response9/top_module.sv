module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire q_temp;

    assign q = q_temp;

    always @(*)
    begin
        case ({c, d})
            2'b00: q_temp = 1'b0;
            2'b01: q_temp = b;
            2'b10: q_temp = a;
            2'b11: q_temp = 1'b1;
        endcase
    end

endmodule
