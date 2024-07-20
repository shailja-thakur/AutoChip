module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b00??: f = f; // don't-care cases should maintain the previous value of f
        4'b010?: f = 1;
        4'b011?: f = 1;
        4'b11??: f = 1;
        4'b10??: f = 0;
        default: f = 0;
    endcase
end

endmodule
