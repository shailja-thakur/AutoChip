module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] inv_a = ~{a,a,a,a,a};
    wire [24:0] inv_b = ~{b,b,b,b,b};
    wire [24:0] inv_c = ~{c,c,c,c,c};
    wire [24:0] inv_d = ~{d,d,d,d,d};
    wire [24:0] inv_e = ~{e,e,e,e,e};

    wire [24:0] concat_a = {a,a,a,a,a};
    wire [24:0] concat_b = {b,b,b,b,b};
    wire [24:0] concat_c = {c,c,c,c,c};
    wire [24:0] concat_d = {d,d,d,d,d};
    wire [24:0] concat_e = {e,e,e,e,e};

    assign out = inv_a ^ concat_a ^ inv_b ^ concat_b ^ inv_c ^ concat_c ^ inv_d ^ concat_d ^ inv_e ^ concat_e;

endmodule
