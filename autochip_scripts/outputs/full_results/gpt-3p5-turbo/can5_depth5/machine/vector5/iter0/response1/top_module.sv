module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] not_a, not_b, not_c, not_d, not_e;
wire [24:0] xor_vector;

assign not_a = ~a;   // Inverting signals a
assign not_b = ~b;   // Inverting signals b
assign not_c = ~c;   // Inverting signals c
assign not_d = ~d;   // Inverting signals d
assign not_e = ~e;   // Inverting signals e

assign out = {5{not_a, not_b, not_c, not_d, not_e}} ^ {5{a,b,c,d,e}};

endmodule
