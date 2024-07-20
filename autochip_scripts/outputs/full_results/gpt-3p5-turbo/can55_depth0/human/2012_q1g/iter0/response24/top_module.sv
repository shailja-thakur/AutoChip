module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[3], x[4], x[1], x[2]})
        4'b0000: f = 1;
        4'b0001: f = 0;
        4'b0011: f = 1;
        4'b0010: f = 1;
        4'b0111: f = 1;
        4'b0101: f = 1;
        4'b0100: f = 0;
        4'b1110: f = 0;
        default: f = 0; // Set a default value for any other input combination
    endcase
end

endmodule
