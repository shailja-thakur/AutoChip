module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0000, 4'b0101, 4'b1100, 4'b1101, 4'b1110: f = 1'b0;
        4'b0001, 4'b0011, 4'b0111, 4'b1001, 4'b1010: f = 1'b1;
        4'b0010, 4'b1011, 4'b1111: f = 1'b1; // Previously had f = 1'b0 for these don't-care conditions
        default: f = 1'b0; // Added a default case to handle any other input combinations
    endcase
end

endmodule
