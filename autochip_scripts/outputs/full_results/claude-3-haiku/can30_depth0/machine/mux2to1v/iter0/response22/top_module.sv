module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

always @(*) begin
    if (sel == 1'b0) begin
        out = a;
    end else begin
        out = b;
    end
end

endmodule
