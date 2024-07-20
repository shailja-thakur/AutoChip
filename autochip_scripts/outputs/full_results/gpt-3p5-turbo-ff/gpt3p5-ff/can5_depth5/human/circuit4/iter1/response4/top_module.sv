module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    always @(*) begin
        if (~a & ~b & ~c & d) begin
            q = 1'b0;
        end else if (~a & ~b & c) begin
            q = 1'b0;
        end else if (~a & b & ~c) begin
            q = 1'b0;
        end else if (~a & b & c) begin
            q = 1'b0;
        end else if (a & ~b & ~c & d) begin
            q = 1'b0;
        end else if (a & ~b & c) begin
            q = 1'b0;
        end else if (a & b & c) begin
            q = 1'b0;
        end else if (a & b & ~c) begin
            q = 1'b0;
        end else begin
            q = 1'b1;
        end
    end
endmodule
