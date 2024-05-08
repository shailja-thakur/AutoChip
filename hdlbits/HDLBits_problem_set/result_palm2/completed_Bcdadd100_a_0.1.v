module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [399:0] sum_bits;
    wire [399:0] carry_bits;

    // Instantiate 100 copies of bcd_fadd to create a 100-digit BCD ripple-carry adder.
    for (int i = 0; i < 100; i++) {
        bcd_fadd bcd_fadd_i (
            .a (a[i*4:i*4+3]),
            .b (b[i*4:i*4+3]),
            .cin (carry_bits[i*4]),
            .cout (carry_bits[i*4+1]),
            .sum (sum_bits[i*4])
        );
    }

    // Connect the carry bits from the BCD adders to the carry-in of the next adder.
    for (int i = 0; i < 99; i++) {
        carry_bits[i*4+2] = carry_bits[i*4+1];
    }

    // Connect the sum bits from the BCD adders to the sum.
    sum = sum_bits[399:0];

    // Connect the carry-out of the last adder to the cout.
    cout = carry_bits[399];

endmodule