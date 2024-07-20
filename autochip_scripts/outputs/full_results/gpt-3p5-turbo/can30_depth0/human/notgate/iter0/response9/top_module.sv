module top_module(
    input in,
    output out
);
    
    not_gate not1(
        .in(in),
        .out(out)
    );
    
endmodule
module not_gate(
    input in,
    output out
);
    
    assign out = ~in;
    
endmodule
