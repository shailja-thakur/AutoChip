module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);
    
    reg [7:0] sel_internal;
    assign sel_internal = sel;
    
    assign out = in[sel_internal];
    
endmodule
