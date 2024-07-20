module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0000, 4'b0101, 4'b1100, 4'b1110: f = 1'b0;
        4'b0001, 4'b0011, 4'b0111, 4'b1001, 4'b1010, 4'b1011: f = 1'b1;
        default: f = 1'b1; // Assign 1 for don't care conditions
    endcase
end

endmodule
