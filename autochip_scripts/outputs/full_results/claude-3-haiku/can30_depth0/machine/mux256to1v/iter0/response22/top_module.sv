module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    localparam INDEX_WIDTH = 10;

    wire [INDEX_WIDTH-1:0] start_index;

    assign start_index = sel * 4;

    assign out = in[start_index +: 4];

endmodule
