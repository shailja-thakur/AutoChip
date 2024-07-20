module top_module(
    input x,
    input y,
    output z);

    wire a;
    wire b;

    gate1 gate1_inst(.a(x), .b(y), .z(a));
    gate2 gate2_inst(.a(y), .b(x), .z(b));
    gate3 gate3_inst(.a(a), .b(b), .z(z));

endmodule
module gate1(a, b, z);
    input a;
    input b;
    output z;
    
    // logic for gate 1
    assign z = a & b;
endmodule
module gate2(a, b, z);
    input a;
    input b;
    output z;
    
    // logic for gate 2
    assign z = a | b;
endmodule
module gate3(a, b, z);
    input a;
    input b;
    output z;
    
    // logic for gate 3
    assign z = a ^ b;
endmodule
