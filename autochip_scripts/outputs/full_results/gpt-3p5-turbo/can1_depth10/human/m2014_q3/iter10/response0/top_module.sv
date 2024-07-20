module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b00??: f = 0;     // when x[3]=0, x[4]=0
        4'b010?: f = 0;     // when x[3]=0, x[4]=1
        4'b011?: f = 1;     // when x[3]=0, x[4]=1
        4'b110?: f = 1;     // when x[3]=1, x[4]=0
        4'b1???: f = 1;     // when x[3]=1, x[4]=1
        default: f = 0;      // for all other cases
    endcase
end

endmodule
