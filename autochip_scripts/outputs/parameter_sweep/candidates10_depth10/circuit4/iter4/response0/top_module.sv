module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire q
);

    reg q_reg;

    always @(*)
    begin
        case ({c, d})
            2'b00: q_reg = 1'b1;
            2'b01: q_reg = b;
            2'b10: q_reg = a;
            2'b11: q_reg = 1'b1;
        endcase
    end

    assign q = q_reg;

endmodule
