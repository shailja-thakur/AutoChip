module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    reg [3:0] block_index;
    
    always @(*) begin
        // Calculate the starting index of the 4-bit block in the input vector
        block_index = sel * 4;
    end
    
    assign out = in[block_index +: 4];
    
endmodule
