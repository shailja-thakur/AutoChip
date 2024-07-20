module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @ (*) begin
    if (a == b) begin
        q = b;
    end else if (a < b) begin
        q = e;
    end else begin
        q = f;
    end
end

endmodule
