module top_module (
    input [4:1] x,
    output logic f
);

logic [3:0] p; // Intermediate variable to store the function values

always_comb begin
    // Implement the function based on the Karnaugh map
    p[0] = (x[4:3] == 2'b00) | (x[4:3] == 2'b10); // x[3:0] = 0x or 1x
    p[1] = (x[4:3] == 2'b11) & (x[2:1] == 2'b11); // x[3:0] = 11x
    p[2] = (x[4:3] == 2'b11) | (x[2:1] == 2'b11); // x[3:0] = 1xx or x1x
    p[3] = (x[4:3] == 2'b10) | (x[2:1] == 2'b00); // x[3:0] = x0 or 1x

    // Combine the intermediate variables to get the final result
    f = p[0] | p[1] | p[2] | p[3];
end

endmodule
