module top_module (
    input a,
    input b,
    input sel,
    output reg out
);

always @(*) begin
    case (sel)
        0: out = a;
        1: out = b;
        default: out = 0; // Assign a default value in case sel is not 0 or 1
    endcase
end

endmodule
