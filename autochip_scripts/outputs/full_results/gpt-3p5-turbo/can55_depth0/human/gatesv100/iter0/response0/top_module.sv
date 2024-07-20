module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    reg [98:0] out_both_reg;
    reg [99:1] out_any_reg;
    reg [99:0] out_different_reg;

    always @* begin
        // Calculate out_both
        out_both_reg[0] = in[0] & in[99];
        out_both_reg[1:98] = in[1:98] & in[0:97];

        // Calculate out_any
        out_any_reg[1:98] = in[0:97] | in[1:98];
        out_any_reg[99] = in[99] | in[0];

        // Calculate out_different
        out_different_reg[0] = in[0] ^ in[99];
        out_different_reg[1:98] = in[1:98] ^ in[0:97];
        out_different_reg[99] = in[99] ^ in[0];
    end

    assign out_both = out_both_reg;
    assign out_any = out_any_reg;
    assign out_different = out_different_reg;

endmodule
