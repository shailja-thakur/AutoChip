// Implement the circuit described by the Karnaugh map below. Values in bracket show the correponding binary

|          | a'(0) | a(1) |
|----------|-------|------|
| b'c'(00) | 1     | 1    |
| b'c (01) | 1     | 1    |
| bc (11)  | 1     | 1    |
| bc'(10)  | 1     | 1    |

// Try to simplify the k-map before coding it. Try both product-of-sums and sum-of-products forms. We can't check whether you have the optimal simplification of the k-map. But we can check if your reduction is equivalent, and we can check whether you can translate a k-map into a circuit.

module top_module(
    input a,
    input b,
    input c,
    output out  ); 

    // Insert your code here

endmodule