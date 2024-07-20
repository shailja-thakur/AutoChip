module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    reg [5:1] y_bits;

    always @ (*)
    begin
        y_bits = y[5:1];  // Corrected indexing of y_bits
        Y2 = y[0] & ~w;  // Corrected indexing of y
        Y4 = y_bits & w;  // Corrected indexing of y_bits
    end

endmodule
