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
        default: out = 'bz; // Assign high-impedance state for undefined sel value
    endcase
end

endmodule
