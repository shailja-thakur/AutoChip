module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        // Extracting bits for readability
        logic x1 = x[1];
        logic x2 = x[2];
        logic x3 = x[3];
        logic x4 = x[4];

        // Implementing the function f based on the given Karnaugh map
        f = (~x3 & ~x4 & ~x1 & x2) | // 00 for x3x4 and 00 for x1x2: f = 1
            (~x3 & ~x4 & x1 & x2)   | // 00 for x3x4 and 10 for x1x2: f = 1
            (x3 & x4 & ~x1)         | // 11 for x3x4 and 11/10 for x1x2: f = 1
            (x3 & ~x4 & x1)         | // 10 for x3x4 and 01/11 for x1x2: f = 1
            (x3 & ~x4 & ~x1 & x2 & x2); // 10 for x3x4 and 10 for x1x2: f = 1
    end

endmodule
