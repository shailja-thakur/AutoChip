module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // declare internal variables
    reg [9:0] start_index;

    // calculate the starting index for the selected 4-bit block
    always @(*) begin
        start_index = sel << 3;
    end

    // extract the selected 4-bit block from the input vector
    always @(*) begin
        out = in[start_index +: 4];
    end

endmodule
