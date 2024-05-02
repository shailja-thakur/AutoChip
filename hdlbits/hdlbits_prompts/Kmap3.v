// Implement the circuit described by the Karnaugh map below. d is don't-care a particular cell in the following map, which means you may choose to output whatever value is convenient.

|       | a'b' | a'b  | ab  | ab' |
|-------|------|------|-----|-----|
| c'd'  | d    | 0    | 1   | 1   |
| c'd   | 0    | 0    | d   | d   |
| cd    | 0    | 1    | 1   | 1   |
| cd'   | 0    | 1    | 1   | 1   |


// Try to simplify the k-map before coding it. Try both product-of-sums and sum-of-products forms. We can't check whether you have the optimal simplification of the k-map. But we can check if your reduction is equivalent, and we can check whether you can translate a k-map into a circuit.

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    // Insert your code here

endmodule
