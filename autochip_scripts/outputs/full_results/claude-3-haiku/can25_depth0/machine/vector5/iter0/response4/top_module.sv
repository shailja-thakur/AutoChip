module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_bits, b_bits, c_bits, d_bits, e_bits;
wire [24:0] first_vector, second_vector;

// Create the first vector
assign a_bits = {5{~a}};
assign b_bits = {5{~b}};
assign c_bits = {5{~c}};
assign d_bits = {5{~d}};
assign e_bits = {5{~e}};
assign first_vector = {a_bits, b_bits, c_bits, d_bits, e_bits};

// Create the second vector
assign second_vector = {5{a,b,c,d,e}};

// Compute the bitwise exclusive-or
assign out = first_vector ^ second_vector;

endmodule
