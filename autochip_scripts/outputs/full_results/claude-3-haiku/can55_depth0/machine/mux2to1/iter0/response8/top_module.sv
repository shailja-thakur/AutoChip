module top_module (
    input a,
    input b,
    input sel,
    output reg out
);

always @(*) begin
    if (sel) begin
        out = b;
    end else begin
        out = a;
    end
end

endmodule
