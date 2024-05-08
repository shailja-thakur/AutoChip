module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);

    connect mod_a.out1 to out1;
    connect mod_a.out2 to out2;
    connect a to mod_a.a;
    connect b to mod_a.b;
    connect c to mod_a.c;
    connect d to mod_a.d;

endmodule