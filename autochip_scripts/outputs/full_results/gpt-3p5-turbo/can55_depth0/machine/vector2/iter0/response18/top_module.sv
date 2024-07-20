module top_module (
    input [31:0] in,
    output [31:0] out
);

    reg [7:0] chunk1;
    reg [7:0] chunk2;
    reg [7:0] chunk3;
    reg [7:0] chunk4;
    wire [7:0] arranged_chunk1;
    wire [7:0] arranged_chunk2;
    wire [7:0] arranged_chunk3;
    wire [7:0] arranged_chunk4;
  
    assign arranged_chunk1 = in[7:0];
    assign arranged_chunk2 = in[15:8];
    assign arranged_chunk3 = in[23:16];
    assign arranged_chunk4 = in[31:24];
  
    assign out[7:0] = arranged_chunk1;
    assign out[15:8] = arranged_chunk2;
    assign out[23:16] = arranged_chunk3;
    assign out[31:24] = arranged_chunk4;

endmodule
