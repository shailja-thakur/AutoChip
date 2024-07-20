module top_module (
    input [3:0] in,
    output reg [2:0] out_both,
    output reg [3:1] out_any,
    output reg [3:0] out_different
);

always @(in) begin
    out_both = in[2:0] & in[3:1];
    out_any = in[2:0] | in[3:1];
    out_different = in ^ {in[3:1], in[0]};
end

endmodule
