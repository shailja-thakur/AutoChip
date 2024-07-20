module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

always @(*) begin
    case (sel)
        1'b0: out = b;
        1'b1: out = a;
        default: out = 8'h0;
    endcase
end

endmodule
