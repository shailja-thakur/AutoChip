module top_module(
    input x,
    input y,
    output z
);

    wire a_first;
    wire b_first;
    wire a_second;
    wire b_second;

    // First gate
    and gate1(.a = x, .b = y, .z = a_first);
    // Second gate
    and gate2(.a = y, .b = x, .z = b_first);
    // Third gate
    or gate3(.a = a_first, .b = b_first, .z = a_second);
    // Fourth gate
    xor gate4(.a = x, .b = y, .z = b_second);
    // Fifth gate
    or gate5(.a = a_second, .b = b_second, .z = z);

endmodule
module and(
    input a,
    input b,
    output z
);
    assign z = a & b;
endmodule
module or(
    input a,
    input b,
    output z
);
    assign z = a | b;
endmodule
module xor(
    input a,
    input b,
    output z
);
    assign z = a ^ b;
endmodule
