module top_module (
    input [31:0] in,
    output [31:0] out
);

    wire [7:0] chunk0, chunk1, chunk2, chunk3;
    
    assign chunk0 = in[7:0];
    assign chunk1 = in[15:8];
    assign chunk2 = in[23:16];
    assign chunk3 = in[31:24];
    
    assign out[7:0] = chunk3;
    assign out[15:8] = chunk2;
    assign out[23:16] = chunk1;
    assign out[31:24] = chunk0;

endmodule
