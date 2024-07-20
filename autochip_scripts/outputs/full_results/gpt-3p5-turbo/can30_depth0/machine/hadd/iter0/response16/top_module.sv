module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    wire [1:0] sum_wires;       // Define a wire for the sum output
    wire cout_wire;             // Define a wire for the cout output

    // Adder logic
    assign sum_wires = a + b;    // Calculate the sum of a and b
    assign cout_wire = a[1] & b[1];  // Calculate the cout by ANDing the MSB of a and b

    // Drive the sum and cout outputs
    assign sum = sum_wires[0];
    assign cout = sum_wires[1] | cout_wire;

endmodule
