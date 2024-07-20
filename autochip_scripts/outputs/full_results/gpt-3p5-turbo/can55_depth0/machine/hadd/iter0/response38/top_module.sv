module top_module (
    input a,
    input b,
    output sum,
    output cout
);

// Declare internal wires
wire carry_in;
wire [31:0] sum_internal;

// Assign carry_in to 0
assign carry_in = 1'b0;

// Perform addition
assign {carry_out, sum_internal} = a + b + carry_in;

// Assign the sum and cout outputs
assign sum = sum_internal;
assign cout = carry_out;

endmodule
