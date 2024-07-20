module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire w0, w1, w2, w3;
    
    assign w0 = (a & !b & !c & !d);
    assign w1 = (!a & b & !c & !d);
    assign w2 = (!a & !b & !c & d);
    assign w3 = (!a & !b & !c & !d);

    assign out_sop = w0 | w1 | w3;
    assign out_pos = !w2;
    
endmodule
