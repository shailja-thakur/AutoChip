module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
    // Define 4 full adder instances
    wire [3:0] c;
    wire [4:0] s;
    
    full_adder fa0(.a(x[0]), .b(y[0]), .c_in(1'b0), .s(s[0]), .c(c[0]));
    full_adder fa1(.a(x[1]), .b(y[1]), .c_in(c[0]), .s(s[1]), .c(c[1]));
    full_adder fa2(.a(x[2]), .b(y[2]), .c_in(c[1]), .s(s[2]), .c(c[2]));
    full_adder fa3(.a(x[3]), .b(y[3]), .c_in(c[2]), .s(s[3]), .c(c[3]));
    
    // Assign sum and overflow bits
    assign sum = {c[3], s[3:0]};
    
endmodule
module full_adder (
    input a,
    input b,
    input c_in,
    output s,
    output c
);

    // Define internal wires
    wire s1, s2;
    
    // Define XOR and AND gates
    xor_gate xg1(.a(a), .b(b), .y(s1));
    xor_gate xg2(.a(s1), .b(c_in), .y(s));
    and_gate ag1(.a(a), .b(b), .y(s2));
    and_gate ag2(.a(s2), .b(c_in), .y(c));
    or_gate og1(.a(s2), .b(c_in), .y(c));
    
endmodule
module xor_gate (
    input a,
    input b,
    output y
);
    assign y = a ^ b;
endmodule
module and_gate (
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module or_gate (
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
