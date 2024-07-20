module A(
    input x,
    input y,
    output z);
    assign z = (x^y) & x;
endmodule
module B(
    input x,
    input y,
    output z);
    assign z = #(5) (x | y);
endmodule
module top_module(
    input x,
    input y,
    output z);
    wire z_a1, z_a2, z_b1, z_b2, or_output, and_output;
    
    // Instantiate A submodules
    A a1 (.x(x), .y(y), .z(z_a1));
    A a2 (.x(x), .y(y), .z(z_a2));
    
    // Instantiate B submodules
    B b1 (.x(x), .y(y), .z(z_b1));
    B b2 (.x(x), .y(y), .z(z_b2));
    
    // OR gate
    assign #(0) or_output = z_a1 | z_b1;
    
    // AND gate
    assign #(0) and_output = z_a2 & z_b2;
    
    // XOR gate
    assign #(0) z = or_output ^ and_output;
    
endmodule
