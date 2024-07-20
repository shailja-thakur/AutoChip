module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;

// Instantiate first gate (AND gate)
    and u1(out1, x, y);

// Instantiate second gate (OR gate)
    or u2(out2, y, x);

// Instantiate third gate (XOR gate)
    xor u3(z, out1, out2);

endmodule
