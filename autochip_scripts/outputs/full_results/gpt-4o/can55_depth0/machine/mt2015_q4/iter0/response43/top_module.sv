module top_module(
    input x,
    input y,
    output z);

    wire gate1_out, gate2_out;

    // First gate (assume AND gate)
    assign gate1_out = x & y; // 'a' input is x, 'b' input is y

    // Second gate (assume OR gate)
    assign gate2_out = y | x; // 'a' input is y, 'b' input is x

    // Third gate (assume XOR gate)
    assign z = gate1_out ^ gate2_out; // 'a' input is gate1_out, 'b' input is gate2_out

endmodule
