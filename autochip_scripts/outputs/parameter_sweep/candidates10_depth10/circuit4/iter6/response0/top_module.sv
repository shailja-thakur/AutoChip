module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire q
 );

    assign q = (c & ~d) | (a & ~b);
    
endmodule
