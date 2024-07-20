module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in)
    casez(in)
        8'bzzzzzzz1: pos <= 3'h0;
        8'bz1zzzzzz: pos <= 3'h6;
        default: pos <= 3'h0;
    endcase
    
endmodule
