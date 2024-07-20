module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    
    // Instantiate a full adder module
    full_adder fa0 (
        .a(a),
        .b(b),
        .cin(cin),
        .cout(cout),
        .sum(sum)
    );
    
endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    
    assign sum = a ^ b ^ cin; // XOR of a, b, and cin gives the sum
    assign cout = (a & b) | (cin & (a ^ b)); // Calculate the carry out
    
endmodule
