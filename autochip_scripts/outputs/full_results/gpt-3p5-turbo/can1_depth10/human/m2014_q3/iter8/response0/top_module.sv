module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b00??: f = 1;     // when x[3]=0, x[4]=0
        4'b010?: f = 0;     // when x[3]=0, x[4]=1
        4'b0111: f = 1;     // when x[3]=0, x[4]=1, x[1]=1
        4'b0110: f = 0;     // when x[3]=0, x[4]=1, x[1]=0
        4'b10??: f = 1;     // when x[3]=1, x[4]=0
        4'b1???: f = 1;     // when x[3]=1, x[4]=1
        default: f = 1;      // for all other cases
    endcase
end

endmodule
