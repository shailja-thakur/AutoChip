module top_module (
    input a,
    input b,
    output reg q
);

always @(*) begin
    if (a & b) begin
        q = 1'b1;
    end else begin
        q = 1'b0;
    end
end

endmodule
