module top_module(
    input in,
    output out
);
    wire not_out;
    not_gate u1(
        .in(in),
        .out(not_out)
    );
    assign out = not_out;
    
    // Define a NOT gate module
    module not_gate(
        input in,
        output out
    );
        assign out = ~in;
    endmodule
