module A (
    input x,
    input y,
    output z
);
    
    assign z = (x ^ y) & x;
    
endmodule
module B (
    input x,
    input y,
    output z
);
    
    wire z_delay; // Introduce a wire to capture the delay
    
    // Define a delay
    #5 z_delay = z; 
    
    assign z = z_delay;
    
endmodule
module top_module(
    input x,
    input y,
    output z
);
    
    wire a1_out, a2_out, b1_out, b2_out;
    wire or_out, and_out;

    // Instantiate the A modules
    A a1(
        .x(x),
        .y(y),
        .z(a1_out)
    );
    A a2(
        .x(x),
        .y(y),
        .z(a2_out)
    );

    // Instantiate the B modules
    B b1(
        .x(x),
        .y(y),
        .z(b1_out)
    );
    B b2(
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR gate between a1_out and b1_out
    assign or_out = a1_out | b1_out;

    // AND gate between a2_out and b2_out
    assign and_out = a2_out & b2_out;

    // XOR gate between or_out and and_out
    assign z = or_out ^ and_out;
    
endmodule
