module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // The first gate receives x and y as inputs (AND gate)
    and gate1(out1, x, y);
    
    // The second gate receives y and x as inputs (OR gate)
    or gate2(out2, y, x);
    
    // The third gate receives the outputs of the first two gates as inputs (XOR gate)
    xor gate3(z, out1, out2);

endmodule
