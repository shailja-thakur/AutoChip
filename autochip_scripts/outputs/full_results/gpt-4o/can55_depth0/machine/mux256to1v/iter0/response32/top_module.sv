module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);
    always @(*) begin
        // Calculate the starting index
        integer start_idx;
        start_idx = sel * 4;
        
        // Extract the 4-bit block
        out = in[start_idx +: 4];
    end
endmodule
