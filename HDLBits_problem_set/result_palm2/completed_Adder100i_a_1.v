module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    // Instantiate 100 full adders
    full_adder fa[99:0];

    // Connect the inputs of the full adders
    for (int i = 0; i < 100; i++) begin
        fa[i].a <= a[i];
        fa[i].b <= b[i];
        fa[i].cin <= cin;
    end

    // Connect the outputs of the full adders
    for (int i = 0; i < 99; i++) begin
        cout[i] <= fa[i+1].cout;
        sum[i] <= fa[i+1].sum;
    end

    // The final carry-out is the carry-out of the last full adder
    cout[99] <= fa[100].cout;

endmodule