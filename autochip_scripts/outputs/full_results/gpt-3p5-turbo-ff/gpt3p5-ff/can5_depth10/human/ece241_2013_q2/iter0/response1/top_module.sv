module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire cond1, cond2, cond3, cond4, cond5, cond6, cond7, cond8;

    assign cond1 = (a==0) && (b==0) && (c==0) && (d==0);
    assign cond2 = (a==0) && (b==0) && (c==1) && (d==0);
    assign cond3 = (a==1) && (b==1) && (c==0) && (d==0);
    assign cond4 = (a==1) && (b==0) && (c==1) && (d==1);
    assign cond5 = (a==0) && (b==1) && (c==1) && (d==0);
    assign cond6 = (a==0) && (b==1) && (c==0) && (d==1);
    assign cond7 = (a==1) && (b==0) && (c==1) && (d==0);
    assign cond8 = (a==1) && (b==0) && (c==1) && (d==1);

    assign out_sop = cond1 | cond2 | cond3 | cond4;
    assign out_pos = !(cond1 & cond2 & cond3 & cond4);

endmodule
