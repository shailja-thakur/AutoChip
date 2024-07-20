module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] q3, q2, q1, q0;

// Synchronous counter
always @(posedge clk) begin
    if(reset) begin
        q3 <= 0;
        q2 <= 0;
        q1 <= 0;
        q0 <= 0;
    end else begin
        q3 <= q3 + ena[3];
        q2 <= q2 + ena[2];
        q1 <= q1 + ena[1];
        q0 <= q0 + 1;
    end
end

assign q = {q3, q2, q1, q0};

endmodule
