module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire and1_out;
    wire and2_out;

    and and1 (and1_out, a, b);  // AND gate for inputs a and b
    and and2 (and2_out, c, d);  // AND gate for inputs c and d

    or or1 (out, and1_out, and2_out); // OR gate to combine the AND outputs

    not not1 (out_n, out); // NOT gate for inverted output

endmodule
