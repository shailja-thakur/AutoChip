module top_module(
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);

    assign {o0, o1, o2} = vec;
    assign outv = vec;
    
endmodule
