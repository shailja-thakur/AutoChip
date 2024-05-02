Sure, here is a 32-bit adder that you can use:

```
module add32 (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire [15:0] sum16;
    wire [15:0] sum16_h;
    wire [15:0] sum16_l;

    module add16 (
        input [15:0] a,
        input [15:0] b,
        input cin,
        output [15:0] sum,
        output cout
    );

        assign sum = a + b + cin;
        assign cout = (a > b) ? 1 : 0;

    endmodule

    add16 add16_l (a[15:0], b[15:0], 0, sum16_l, cout16_l);
    add16 add16_h (a[31:16], b[31:16], 0, sum16_h, cout16_h);

    assign sum[31:16] = sum16_h;
    assign sum[15:0] = sum16_l;

endmodule
```

This adder uses two add16 modules to perform the addition. The add16 modules are connected in series, with the carry-out of the lower 16-bit adder being connected to the carry-in of the upper 16-bit adder. The sum of the two add16 modules is then the 32-bit sum.