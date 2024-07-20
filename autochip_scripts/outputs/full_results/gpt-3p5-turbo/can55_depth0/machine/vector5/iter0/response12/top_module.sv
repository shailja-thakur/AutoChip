module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] not_vector;
    wire [24:0] input_vector;
    
    assign not_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign input_vector = {5{a,b,c,d,e}};
    
    assign out = not_vector ^ input_vector;
    
endmodule
