module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

wire out_sop_wire;
wire out_pos_wire;

assign out_sop_wire = a & (!b) & (!c) & (!d) | (!a) & (!b) & c & (!d) | (!a) & (!b) & (!c) & d;
assign out_pos_wire = (a | b | c | d) & (!a | b | c | d) & (a | !b | c | d) & (a | b | !c | d) & (a | b | c | !d);

assign out_sop = out_sop_wire;
assign out_pos = out_pos_wire;

endmodule
