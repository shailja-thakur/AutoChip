module top_module (
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:0] out_any,
    output reg [99:0] out_different
);

    wire [99:0] in_shifted;

    assign in_shifted = in << 1;

    always @(*) begin
        out_both = in[99:1] & in_shifted[99:1];
        out_any = in | in_shifted;
        out_different = in ^ {in[0], in[99:1]};
    end

endmodule
