module top_module (
    input d,
    input ena,
    output reg q
);

always @(*) begin
    if (ena)
        q = d;
end

endmodule
