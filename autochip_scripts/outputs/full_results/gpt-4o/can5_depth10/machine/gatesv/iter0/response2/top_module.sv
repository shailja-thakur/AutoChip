module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output reg [3:0] out_different
);

    assign out_both = in[2:0] & in[3:1];
    assign out_any = {in[3] | in[2], in[2] | in[1], in[1] | in[0], in[0]};

    always @(*) begin
        out_different[3] = in[3] ^ in[0];
        out_different[2] = in[2] ^ in[3];
        out_different[1] = in[1] ^ in[2];
        out_different[0] = in[0] ^ in[1];
    end

endmodule
