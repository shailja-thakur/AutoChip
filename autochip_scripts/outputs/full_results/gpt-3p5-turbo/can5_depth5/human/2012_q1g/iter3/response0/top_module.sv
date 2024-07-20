module top_module (
    input [4:1] x,
    output logic f
);

// Implementing the function f using a case statement
// Mismatches occurred because some of the outputs were incorrect in the original code.

always_comb begin
    case(x)
        4'b0000, 4'b0001, 4'b1001: f = 1'b1; // adding 4'b1001 to set f to 1 when x is 4'b1001
        4'b0010, 4'b0011, 4'b0101, 4'b0110, 4'b0111, 4'b1010: f = 1'b0;
        4'b1011, 4'b1100: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
