module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

    // Intermediate signals
    wire p1_and, p2_and;

    // Logic gates
    and gate_p1(p1_and, p1a, p1b, p1c, p1d);
    and gate_p2(p2_and, p2a, p2b, p2c, p2d);

    // Inverter for p1y and p2y
    not inv_p1(p1y, p1_and);
    not inv_p2(p2y, p2_and);

endmodule
module and(
    output y,
    input a, 
    input b, 
    input c, 
    input d
);
    assign y = a & b & c & d;
endmodule
module not(
    output y,
    input a
);
    assign y = ~a;
endmodule
