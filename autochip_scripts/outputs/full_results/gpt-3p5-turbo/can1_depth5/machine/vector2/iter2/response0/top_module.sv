module top_module (
    input [31:0] in,
    output reg [31:0] out
);

    always @(*) begin
        out = {in[7:0], in[15:8], in[23:16], in[31:24]};
    end

endmodule
