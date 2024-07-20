module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    wire [3:0] in_sel [255:0];

    genvar i;

    generate
        for (i=0; i<256; i=i+1) begin: MUX
            assign in_sel[i] = in[(i+1)*4-1:i*4];
        end
    endgenerate

    assign out = in_sel[sel];
endmodule
