module top_module(
    input x,
    input y,
    output z);
    
    wire output1, output2;

    and gate1 (output1, x, y);
    or gate2 (output2, x, y);
    xor gate3 (z, output1, output2);

endmodule
