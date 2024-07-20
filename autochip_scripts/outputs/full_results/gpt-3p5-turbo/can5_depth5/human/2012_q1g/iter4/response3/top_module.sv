module top_module (
    input [4:1] x,
    output logic f
);

// Implementing the function f using a case statement
always_comb begin
    case(x)
        4'b0001, 4'b0010, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1011: f = 1'b0;
        default: f = 1'b1;
    endcase
end

endmodule
