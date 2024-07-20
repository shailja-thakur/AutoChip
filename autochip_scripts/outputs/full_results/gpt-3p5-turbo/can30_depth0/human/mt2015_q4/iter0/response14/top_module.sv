module top_module(
    input x,
    input y,
    output z);

    wire a_out1;
    wire b_out1;
    wire a_out2;
    wire b_out2;
    wire or_out;
    wire and_out;
    
    A a1(x, y, a_out1);
    A a2(x, y, a_out2);
    
    B b1(x, y, b_out1);
    B b2(x, y, b_out2);
    
    OR or_gate(or_out, a_out1, b_out1);
    AND and_gate(and_out, a_out2, b_out2);

    XOR xor_gate(z, or_out, and_out);

endmodule
module A(
    input x,
    input y,
    output z);
    
    wire xor_out;
    wire and_out;
    
    XOR xor_gate(xor_out, x, y);
    AND and_gate(and_out, x, xor_out);
    assign z = and_out;
    
endmodule
module B(
    input x,
    input y,
    output z);
    
    reg z;
    
    always @(x, y)
    begin
        case ({x, y})
            2'b00: z = 1;
            2'b01: z = 0;
            2'b11: z = 1;
            default: z = 0;
        endcase
    end
    
endmodule
module OR(
    input x1,
    input x2,
    output y);
    
    assign y = x1 | x2;
    
endmodule
module AND(
    input x1,
    input x2,
    output y);
    
    assign y = x1 & x2;
    
endmodule
module XOR(
    input x1,
    input x2,
    output y);
    
    assign y = x1 ^ x2;
    
endmodule
