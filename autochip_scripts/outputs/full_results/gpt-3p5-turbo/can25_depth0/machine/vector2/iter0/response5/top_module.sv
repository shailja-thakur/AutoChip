module top_module (
    input [31:0] in,
    output [31:0] out
);
    reg [7:0] out_chunk_1;
    reg [7:0] out_chunk_2;
    reg [7:0] out_chunk_3;
    reg [7:0] out_chunk_4;

    assign out = {out_chunk_4, out_chunk_3, out_chunk_2, out_chunk_1};

    always @(*) begin
        out_chunk_1 = in[7:0];
        out_chunk_2 = in[15:8];
        out_chunk_3 = in[23:16];
        out_chunk_4 = in[31:24];
    end
endmodule
