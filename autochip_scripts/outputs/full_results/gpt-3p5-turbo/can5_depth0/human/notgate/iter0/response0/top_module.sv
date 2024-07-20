module top_module(
    input in,
    output out
);
    
    wire not_out;
    
    not_gate not1(
        .in(in),
        .out(not_out)
    );
    
    assign out = not_out;
    
endmodule
module not_gate(
    input in,
    output out
);
    
    assign out = ~in;
    
endmodule
