module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_bus, b_bus, c_bus, d_bus, e_bus;
wire [24:0] not_bus, and_bus;

assign a_bus = {5{a}};
assign b_bus = {5{b}};
assign c_bus = {5{c}};
assign d_bus = {5{d}};
assign e_bus = {5{e}};

assign not_bus = ~{a_bus, b_bus, c_bus, d_bus, e_bus};
assign and_bus = {5{a,b,c,d,e}};

assign out = not_bus ^ and_bus;

endmodule
