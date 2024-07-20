module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    reg c;

    // Register to store the value of c, updated on each clock's rising edge
    always @(posedge clk) begin
        c <= (a & b) | (a & c) | (b & c);
    end

    // Assignments to calculate the outputs
    always @(*) begin
        q = a ^ b ^ c;
        state = c;
    end

endmodule
