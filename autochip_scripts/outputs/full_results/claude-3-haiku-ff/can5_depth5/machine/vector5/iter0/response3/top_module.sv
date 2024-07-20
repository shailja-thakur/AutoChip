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

// Generate 5-bit buses from the input signals
assign a_bus = {5{a}};
assign b_bus = {5{b}};
assign c_bus = {5{c}};
assign d_bus = {5{d}};
assign e_bus = {5{e}};

// Create the 25-bit vectors
assign not_bus = ~{a_bus, b_bus, c_bus, d_bus, e_bus};
assign and_bus = {a_bus, b_bus, c_bus, d_bus, e_bus};

// Compute the bitwise XOR
assign out = not_bus ^ and_bus;

endmodule
