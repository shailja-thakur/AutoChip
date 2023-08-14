// Implement the circuit described by the Karnaugh map below.

|       | a'b' | a'b  | ab  | ab' |
|-------|------|------|-----|-----|
| c'd'  | 0    | 1    | 0   | 1   |
| c'd   | 1    | 0    | 1   | 0   |
| cd    | 0    | 1    | 0   | 1   |
| cd'   | 1    | 0    | 1   | 0   |

// Try to simplify the k-map before coding it. Try both product-of-sums and sum-of-products forms. We can't check whether you have the optimal simplification of the k-map. But we can check if your reduction is equivalent, and we can check whether you can translate a k-map into a circuit.

// Hint: For this function, changing the value of any one input always inverts the output. It is a simple logic function, but one that can't be easily expressed as SOP nor POS forms.

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    // Insert your code here

endmodule
