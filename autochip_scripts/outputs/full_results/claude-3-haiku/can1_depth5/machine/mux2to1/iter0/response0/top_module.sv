module top_module (
    input a,
    input b,
    input sel,
    output reg out
);

always @(*) begin
    case (sel)
        1'b1: out = b;
        1'b0: out = a;
        default: out = 1'bx; // Handle default case for unknown sel value
    endcase
end

endmodule
