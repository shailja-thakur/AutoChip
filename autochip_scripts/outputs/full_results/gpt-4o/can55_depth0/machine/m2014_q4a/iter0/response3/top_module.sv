module top_module (
    input  wire d,
    input  wire ena,
    output reg  q
);

always @(*) begin
    if (ena) begin
        q = d;
    end
end

endmodule
