module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
    
    // Internal signal declarations
    wire sum1, c1, c2;

    // First Half Adder
    assign sum1 = a ^ b; // Sum of A and B
    assign c1 = a & b;   // Carry from A and B

    // Second Half Adder
    assign sum = sum1 ^ cin; // Final Sum including Cin
    assign c2 = sum1 & cin;  // Carry from sum1 and Cin

    // Final Carry-Out
    assign cout = c1 | c2;   // Final Carry-Out

endmodule
