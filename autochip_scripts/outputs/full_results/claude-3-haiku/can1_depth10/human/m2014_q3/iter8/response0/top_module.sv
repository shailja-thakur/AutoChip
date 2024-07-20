module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0001, 4'b0011, 4'b1001, 4'b1101, 4'b1110: f = 1'b1;
        4'b0100, 4'b0101, 4'b0111, 4'b1000, 4'b1010: f = 1'b0;
        4'b1011, 4'b1111: f = 1'b1; // handle don't-care cases
        default: f = 1'b0; // handle any other cases
    endcase
end

endmodule
