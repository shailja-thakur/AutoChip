module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // Define internal signals
    wire w1, w2, w3, w4;

    // Assign internal signals based on combinational logic
    assign w1 = ~(a & b);
    assign w2 = ~(c & d);
    assign w3 = w1 | w2;
    assign w4 = ~w3;

    // Assign output q based on internal signals
    assign q = w4;

endmodule
