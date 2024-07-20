module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    // Declare internal wires for intermediate signals
    wire [31:0] sum_wire;
    wire cout_wire;

    // Adder logic
    assign {cout_wire, sum_wire} = a + b;

    // Output assignments
    assign sum = sum_wire;
    assign cout = cout_wire;

endmodule
