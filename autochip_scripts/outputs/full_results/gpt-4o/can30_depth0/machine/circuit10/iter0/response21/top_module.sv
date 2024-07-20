module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    // Internal register to store c
    reg c;

    always @(posedge clk) begin
        // Calculate value of c as per given logic
        c <= (a & b) | (a & c) | (b & c);
    end

    // Outputs q and state calculation
    always @(posedge clk) begin
        q <= a ^ b ^ c;
        state <= c;
    end

endmodule
