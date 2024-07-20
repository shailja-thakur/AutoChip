module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*) begin
    // Extract the 4-bit block starting at the index specified by 'sel' * 4
    out = in[(sel * 4) +: 4];
end

endmodule
