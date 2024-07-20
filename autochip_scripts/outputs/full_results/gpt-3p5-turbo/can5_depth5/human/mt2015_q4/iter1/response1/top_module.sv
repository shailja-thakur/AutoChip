module A(
    input x,
    input y,
    output z);
    
    assign z = (x ^ y) & x;
    
endmodule
module B(
    input x,
    input y,
    output z);
    
    reg z;
    
    always @(*)
    begin
        #5 z = (x & y) | z;
    end
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a_out, b_out;
    
    A a1(
        .x(x),
        .y(y),
        .z(a_out)
    );
    
    A a2(
        .x(x),
        .y(y),
        .z(b_out)
    );
    
    B b1(
        .x(a_out),
        .y(b_out),
        .z(z)
    );
    
    B b2(
        .x(a_out),
        .y(b_out),
        .z(z)
    );
    
    assign z = a_out ^ b_out;
    
endmodule
