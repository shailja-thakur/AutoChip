module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output reg q
);

    // Use always @(*) for combinational circuits
    always @(*)
    begin
        // Assign output based on the input values
        case ({c, d})
            2'b00: q = 1'b0;
            2'b01: q = b;
            2'b10: q = a;
            default: q = 1'b1; // Add default case to handle unknown input
        endcase
    end

endmodule
