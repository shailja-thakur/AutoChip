module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Calculate the starting index of the 4-bit block in the input vector (in)
    integer start_index;
    always @(*) begin
        start_index = sel * 4;
    end

    // Extract the 4-bit block from the input vector (in) and assign it to the output vector (out)
    assign out = in[start_index +: 4];

endmodule
