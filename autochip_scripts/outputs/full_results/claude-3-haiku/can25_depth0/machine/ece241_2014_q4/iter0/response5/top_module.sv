module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b0; // Register s is 3 bits, initial value is 0

always @(posedge clk) begin
    // Cascade notation for s
    s[2] = s[2] ^ x; // Statement 1
    s[1] = ~s[1] & x; // Statement 2
    s[0] = ~s[0] | x; // Statement 3
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is the NOT of the OR of all bits of s

endmodule
