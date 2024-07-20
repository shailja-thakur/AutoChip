module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Logic gate that performs the OR operation on the inputs
    assign out = a | b | c;

endmodule
