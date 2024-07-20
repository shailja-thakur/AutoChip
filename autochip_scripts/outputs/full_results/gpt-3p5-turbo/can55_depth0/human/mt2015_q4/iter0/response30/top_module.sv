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
    always @(x or y)
        begin
            case(x)
                1'b0: z = 1'b1;
                1'b1:
                case(y)
                    1'b0: z = 1'b0;
                    1'b1: z = 1'b1;
                endcase
            endcase
        end
    
endmodule
module top_module(
    input x,
    input y,
    output z);

    wire z1, z2, z3, z4;
    A a1(.x(x), .y(y), .z(z1));
    A a2(.x(x), .y(y), .z(z2));
    B b1(.x(x), .y(y), .z(z3));
    B b2(.x(x), .y(y), .z(z4));
    or_gate or1(.a(z1), .b(z3), .z(z));
    and_gate and1(.a(z2), .b(z4), .z(z));
    xor_gate xor1(.a(z), .b(z), .z(z));
    
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
