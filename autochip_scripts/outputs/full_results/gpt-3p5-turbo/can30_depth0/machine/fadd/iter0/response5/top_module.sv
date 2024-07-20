module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Internal wire for carry-out bit
    wire cout_wire;
    
    // Internal wire for sum calculation
    wire [1:0] sum_wire;
    
    // Calculate sum = a + b + cin, modulo 2
    assign sum_wire = a + b + cin;
    
    // Calculate cout = 1 if sum >= 2, else cout = 0
    assign cout_wire = (sum_wire >= 2) ? 1'b1 : 1'b0;
    
    // Output assignments
    assign sum = sum_wire[0];
    assign cout = cout_wire;
    
endmodule
