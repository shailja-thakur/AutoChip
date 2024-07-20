module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    reg [3:0] start_index;
    
    always @* begin
        start_index = sel * 4;  // calculate the starting index of the 4-bit block
        out = in[start_index +: 4];  // extract the 4-bit block from the input vector
    end
endmodule
