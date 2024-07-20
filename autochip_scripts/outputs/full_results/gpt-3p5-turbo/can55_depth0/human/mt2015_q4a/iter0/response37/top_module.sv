module top_module(
    input x,
    input y,
    output z
);

    wire temp;
    
    xor gate1 (
        .a(x),
        .b(y),
        .z(temp)
    );
    
    and gate2 (
        .a(temp),
        .b(x),
        .z(z)
    );

endmodule
