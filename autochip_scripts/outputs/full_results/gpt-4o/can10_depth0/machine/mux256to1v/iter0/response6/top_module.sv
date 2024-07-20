module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

    always @(*) begin
        // Calculate starting index from sel
        integer start_idx;
        start_idx = sel * 4;
        
        // Extract 4-bit block from in
        out = in[start_idx +: 4];
    end

endmodule
