module top_module (
    input a,
    input b,
    output q
);

always @(*) begin
    if (a == 1'b1 && b == 1'b1) begin
        q = 1'b1;
    end
    else begin
        q = 1'b0;
    end
end

endmodule
