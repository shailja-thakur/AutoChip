module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Define the logic for out_sop using an OR gate
    assign out_sop = (a & !b & !c & !d) | (!a & !b & c & !d) | (!a & !b & !c & d);

    // Define the logic for out_pos using an AND gate
    assign out_pos = (a | b | c | d) & (!a | b | c | d) & (a | !b | c | d) & (a | b | !c | d) & (a | b | c | !d);

endmodule
