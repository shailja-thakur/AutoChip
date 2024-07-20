module top_module(
    input wire p1a, 
    input wire p1b, 
    input wire p1c, 
    input wire p1d, 
    output wire p1y, 
    input wire p2a, 
    input wire p2b, 
    input wire p2c, 
    input wire p2d, 
    output wire p2y
);

    // Internal wire for intermediate calculations
    wire w1;
  
    // NAND gate 1
    nandgate n1(
        .a(p1a),
        .b(p1b),
        .c(p1c),
        .d(p1d),
        .y(w1)
    );

    // NAND gate 2
    nandgate n2(
        .a(p2a),
        .b(p2b),
        .c(p2c),
        .d(p2d),
        .y(p2y)
    );

    // Output gate
    nandgate n3(
        .a(w1),
        .b(p2a),
        .c(p2b),
        .d(p2c),
        .y(p1y)
    );

endmodule
