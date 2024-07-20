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
    
    always @(x, y)
    begin
        case({x, y})
            {1'b0, 1'b0}: z = 1'b1;
            {1'b1, 1'b0}: z = 1'b0;
            {1'b0, 1'b1}: z = 1'b0;
            {1'b1, 1'b1}: z = 1'b1;
        endcase
    end
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1_z, b1_z, a2_z, b2_z;
    
    A a1(
        .x(x),
        .y(y),
        .z(a1_z)
    );
    
    B b1(
        .x(x),
        .y(y),
        .z(b1_z)
    );
    
    A a2(
        .x(x),
        .y(y),
        .z(a2_z)
    );
    
    B b2(
        .x(x),
        .y(y),
        .z(b2_z)
    );
    
    wire or_output, and_output;
    
    assign or_output = a1_z | b1_z;
    assign and_output = a2_z & b2_z;
    
    assign z = or_output ^ and_output;
    
endmodule
