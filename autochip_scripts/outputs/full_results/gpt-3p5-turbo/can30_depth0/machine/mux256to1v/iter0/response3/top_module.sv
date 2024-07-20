module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [3:0] index; // variable to hold the starting index of the 4-bit block in the input vector
    reg [3:0] temp; // temp variable to extract the 4-bit block from the input vector

    always @(*) begin
        index = sel[6:3]; // calculate the starting index based on the selection vector
        temp = in[index +: 4]; // extract the 4-bit block from the input vector starting from the calculated index
        out = temp; // assign the extracted 4-bit block to the output vector
    end

endmodule
