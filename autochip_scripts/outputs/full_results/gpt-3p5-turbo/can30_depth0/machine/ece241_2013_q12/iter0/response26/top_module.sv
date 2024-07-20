module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

reg [7:0] q;
assign Z = (A & ~B & ~C)? q[0] :
           (~A & B & ~C)? q[1] :
           (A & B & ~C)? q[2] :
           (~A & ~B & C)? q[3] :
           (A & ~B & C)? q[4] :
           (~A & B & C)? q[5] :
           (A & B & C)? q[6] :
           q[7];

always @(posedge clk) begin
    if (enable) begin
        q <= {S, q[7:1]};
    end
end

endmodule
