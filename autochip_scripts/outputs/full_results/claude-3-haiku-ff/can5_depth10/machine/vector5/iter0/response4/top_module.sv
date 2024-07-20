module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [24:0] neg_a = {5{~a}};
wire [24:0] neg_b = {5{~b}};
wire [24:0] neg_c = {5{~c}};
wire [24:0] neg_d = {5{~d}};
wire [24:0] neg_e = {5{~e}};

wire [24:0] pos_a = {5{a}};
wire [24:0] pos_b = {5{b}};
wire [24:0] pos_c = {5{c}};
wire [24:0] pos_d = {5{d}};
wire [24:0] pos_e = {5{e}};

assign out = neg_a ^ neg_b ^ neg_c ^ neg_d ^ neg_e ^ pos_a ^ pos_b ^ pos_c ^ pos_d ^ pos_e;

endmodule
