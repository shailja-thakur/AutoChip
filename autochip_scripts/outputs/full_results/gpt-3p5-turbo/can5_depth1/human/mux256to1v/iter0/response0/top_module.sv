module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [255:0] in_4bit [0:255];
    genvar i;
    
    generate
        for (i = 0; i < 256; i = i + 1) begin : block_name
            assign in_4bit[i] = in[(i * 4) +: 4];
        end
    endgenerate
    
    assign out = in_4bit[sel];
    
endmodule
