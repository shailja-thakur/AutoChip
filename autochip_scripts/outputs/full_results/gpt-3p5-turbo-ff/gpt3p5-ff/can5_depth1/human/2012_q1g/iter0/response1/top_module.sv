module top_module (
    input [4:1] x,
    output logic f
);

// Define the truth table for the function f
always_comb begin
    case (x)
        4'b0000: f = 1'b1;
        4'b0001, 4'b0111, 4'b1100, 4'b1011: f = 1'b0;
        default: f = 1'b1;
    endcase
end

endmodule
