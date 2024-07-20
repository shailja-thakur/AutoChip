module top_module (
    input a, // First input
    input b, // Second input
    input cin, // Carry-in bit
    output cout, // Carry-out bit
    output sum // Sum of a, b, and cin
);
    reg cout;
    wire sum;
    
    assign sum = (a + b + cin) % 2; // Calculate the sum
    assign cout = (a + b + cin) >= 2 ? 1 : 0; // Calculate the carry-out bit
    
endmodule
