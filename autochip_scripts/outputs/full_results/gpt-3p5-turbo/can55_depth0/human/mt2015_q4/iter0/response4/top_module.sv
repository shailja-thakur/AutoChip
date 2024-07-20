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
    initial begin
        #0 z = 1'b1;
        #25 z = (x == 1'b1 && y == 1'b0) ? 1'b0 : 1'b1;
        #35 z = (x == 1'b0 && y == 1'b1) ? 1'b0 : 1'b1;
        #45 z = 1'b1;
        #55 z = (x == 1'b0 && y == 1'b0) ? 1'b1 : 1'b0;
        #60 z = (x == 1'b0 && y == 1'b0) ? 1'b1 : 1'b0;
        #65 z = (x == 1'b0 && y == 1'b0) ? 1'b1 : 1'b0;
        #70 z = 1'b1;
        #75 z = (x == 1'b0 && y == 1'b1) ? 1'b0 : 1'b1;
        #80 z = (x == 1'b0 && y == 1'b1) ? 1'b0 : 1'b1;
        #85 z = (x == 1'b0 && y == 1'b1) ? 1'b0 : 1'b1;
        #90 z = (x == 1'b1 && y == 1'b0) ? 1'b0 : 1'b1;
    end
    
    assign z = z;
    
endmodule
module top_module(
    input x,
    input y,
    output z);
    
    wire a1_z, a2_z, b1_z, b2_z, or_z, and_z;
    
    A a1(.x(x), .y(y), .z(a1_z));
    A a2(.x(x), .y(y), .z(a2_z));
    
    B b1(.x(x), .y(y), .z(b1_z));
    B b2(.x(x), .y(y), .z(b2_z));
    
    or_gate or1(.a(a1_z), .b(b1_z), .z(or_z));
    and_gate and1(.a(a2_z), .b(b2_z), .z(and_z));
    
    xor_gate xor1(.a(or_z), .b(and_z), .z(z));
    
endmodule
module or_gate(
    input a,
    input b,
    output z);
    
    assign z = a | b;
    
endmodule
module and_gate(
    input a,
    input b,
    output z);
    
    assign z = a & b;
    
endmodule
module xor_gate(
    input a,
    input b,
    output z);
    
    assign z = a ^ b;
    
endmodule
