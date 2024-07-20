module top_module (
    input [7:0] in,
    output [31:0] out
);
    wire [7:0] replicated_in;
    
    generate
        genvar i;
        for (i = 0; i < 24; i = i + 1) begin : REPLICATE
            assign replicated_in[i * 8 +: 8] = in;
        end
    endgenerate
    
    assign out = {replicated_in, in};
endmodule
