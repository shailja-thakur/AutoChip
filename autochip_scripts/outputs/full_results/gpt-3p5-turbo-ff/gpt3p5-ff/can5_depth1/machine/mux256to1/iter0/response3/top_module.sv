module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    reg [7:0] address;
    
    always @(sel)
        address <= sel;
    
    assign out = in[address];

endmodule
