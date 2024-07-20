module top_module (
    input d,
    input ena,
    output reg q
);

always @(*) begin
    if (ena) begin
        q = d;
    end
end

endmodule
