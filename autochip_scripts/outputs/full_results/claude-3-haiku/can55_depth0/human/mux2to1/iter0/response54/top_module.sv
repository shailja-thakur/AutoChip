module top_module (
    input a,
    input b,
    input sel,
    output reg out
);

always @(*) begin
    case (sel)
        1'b0: out = a;
        1'b1: out = b;
        default: out = 1'bx; // Assign a don't-care value for unexpected sel values
    endcase
end

endmodule
