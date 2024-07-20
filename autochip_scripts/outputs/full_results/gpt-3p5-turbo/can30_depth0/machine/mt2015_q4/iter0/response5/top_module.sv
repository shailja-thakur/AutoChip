module top_module(
    input x,
    input y,
    output z);

    wire a;
    wire b;
    
    gate1 gate1_inst(
        .a(x),
        .b(y),
        .out_a(a)
    );
    
    gate2 gate2_inst(
        .a(y),
        .b(x),
        .out_b(b)
    );
    
    gate3 gate3_inst(
        .a(a),
        .b(b),
        .out_z(z)
    );
    
endmodule
module gate1(
    input a,
    input b,
    output out_a);
    // Define the behavior of gate1
    assign out_a = a & b;
endmodule
module gate2(
    input a,
    input b,
    output out_b);
    // Define the behavior of gate2
    assign out_b = a | b;
endmodule
module gate3(
    input a,
    input b,
    output out_z);
    // Define the behavior of gate3
    assign out_z = a ^ b;
endmodule
