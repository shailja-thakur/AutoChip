module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b00xx: f = 0;
        4'bx01x: f = 0;
        4'bx11x: f = 1;
        4'bxx10: f = 1;
        default: f = 0; // don't cares
    endcase
end

endmodule
