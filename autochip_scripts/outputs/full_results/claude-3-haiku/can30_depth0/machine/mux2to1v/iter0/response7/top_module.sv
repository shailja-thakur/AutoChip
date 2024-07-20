module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

always @(*) begin
    case (sel)
        1'b0: out = a;
        1'b1: out = b;
        default: out = '0; // Assign a default value in case sel is not 0 or 1
    endcase
end

endmodule
