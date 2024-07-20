module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vector_1;
    wire [24:0] vector_2;
    wire [24:0] vector_3;
    
    assign vector_1 = ~{a,b,c,d,e};
    assign vector_2 = {a,b,c,d,e};
    assign vector_3 = vector_1 ^ vector_2;
    
    assign out = vector_3;
    
endmodule
