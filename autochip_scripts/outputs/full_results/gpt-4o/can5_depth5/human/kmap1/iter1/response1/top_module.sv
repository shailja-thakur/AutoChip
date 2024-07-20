module top_module(
    input a, 
    input b,
    input c,
    output out
);
    assign out = (~a & b) | (a & b) | (~a & ~b & c) | (a & c); // Simplified minterms from K-map
endmodule
