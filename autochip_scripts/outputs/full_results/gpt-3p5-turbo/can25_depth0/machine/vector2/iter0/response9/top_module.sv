module top_module (
    input [31:0] in,
    output [31:0] out
);
    
    // Split the input into 8-bit chunks
    wire [7:0] chunk0 = in[7:0];
    wire [7:0] chunk1 = in[15:8];
    wire [7:0] chunk2 = in[23:16];
    wire [7:0] chunk3 = in[31:24];
    
    // Rearrange the chunks
    assign out = {chunk3, chunk2, chunk1, chunk0};

endmodule
