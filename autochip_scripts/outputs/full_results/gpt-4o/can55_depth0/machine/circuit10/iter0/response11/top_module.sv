module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg c;

    always @(posedge clk) begin
        c <= (a & b) | (a & c) | (b & c); // Calculate c on rising edge of clk
    end

    assign q = a ^ b ^ c; // Calculate q as XOR of a, b, and c
    assign state = c;     // Assign state as the value of c

endmodule
