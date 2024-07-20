module top_module (
    input [31:0] in,
    output [31:0] out
);

    // Declare intermediate wire signals
    wire [7:0] chunk1;
    wire [7:0] chunk2;
    wire [7:0] chunk3;
    wire [7:0] chunk4;

    // Assign the input bits to the output in the desired order
    assign chunk1 = in[7:0];
    assign chunk2 = in[15:8];
    assign chunk3 = in[23:16];
    assign chunk4 = in[31:24];
    assign out = {chunk4, chunk3, chunk2, chunk1};

endmodule
