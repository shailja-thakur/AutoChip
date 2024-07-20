module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    reg out_and_reg;
    reg out_or_reg;
    reg out_xor_reg;

    // Perform the logical AND operation
    assign out_and = out_and_reg;

    // Perform the logical OR operation
    assign out_or = out_or_reg;

    // Perform the logical XOR operation
    assign out_xor = out_xor_reg;

    // Logic to calculate AND
    always @*
    begin
        out_and_reg = &in;
    end

    // Logic to calculate OR
    always @*
    begin
        out_or_reg = |in;
    end

    // Logic to calculate XOR
    always @*
    begin
        out_xor_reg = ^in;
    end

endmodule
