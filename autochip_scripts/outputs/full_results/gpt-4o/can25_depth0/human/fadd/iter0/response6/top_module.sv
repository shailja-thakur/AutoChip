module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign sum = a ^ b ^ cin;         // Sum bit
    assign cout = (a & b) | (b & cin) | (a & cin);  // Carry-out bit
    
endmodule
