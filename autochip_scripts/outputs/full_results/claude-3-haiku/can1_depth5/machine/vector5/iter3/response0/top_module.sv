module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_bus, b_bus, c_bus, d_bus, e_bus;
wire [24:0] first_vector, second_vector;

// Create the first vector
assign a_bus = {5{~a}};
assign b_bus = {5{~b}};
assign c_bus = {5{~c}};
assign d_bus = {5{~d}};
assign e_bus = {5{~e}};
assign first_vector = {a_bus, b_bus, c_bus, d_bus, e_bus};

// Create the second vector
assign a_bus = {5{a}};
assign b_bus = {5{b}};
assign c_bus = {5{c}};
assign d_bus = {5{d}};
assign e_bus = {5{e}};
assign second_vector = {a_bus, b_bus, c_bus, d_bus, e_bus};

// Compute the bitwise XOR
assign out = first_vector ^ second_vector;

endmodule
