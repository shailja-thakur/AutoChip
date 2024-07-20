module top_module (
    input a,
    input b,
    output q
);

always @(*) begin
    if (a & b) begin
        q = 1;
    end else begin
        q = 0;
    end
end

endmodule
