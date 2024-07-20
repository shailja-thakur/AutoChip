module top_module (
    input wire clk,
    input wire a,
    input wire b,
    output reg q,
    output reg state
);

    reg c;

    always @(posedge clk) begin
        c <= (a & b) | (a & c) | (b & c);
    end

    always @(*) begin
        q = a ^ b ^ c;
        state = c;
    end

endmodule
