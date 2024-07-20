module top_module (
    input in1,
    input in2,
    output logic out
);

    // Combinational logic to implement the NAND/NOR gate functionality
    assign out = ~(in1 | in2);

endmodule
