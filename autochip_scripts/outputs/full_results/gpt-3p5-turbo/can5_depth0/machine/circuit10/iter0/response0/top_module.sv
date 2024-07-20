module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);
    reg c;
    wire q, state;

    always @(posedge clk) begin
        c <= (a & b) | (a & c) | (b & c);
    end

    assign q = a ^ b ^ c;
    assign state = c;
endmodule
