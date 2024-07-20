module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000: f = 1'b0;
        4'b0001: f = 1'b0;
        4'b0011: f = 1'b1;
        4'b0010: f = 1'b1;
        4'b0111: f = 1'b0;
        4'b0110: f = 1'b1;
        4'b1100: f = 1'b1;
        4'b1101: f = 1'b1;
        default: f = 1'b0; // Set f to 0 for don't-care conditions
    endcase
end

endmodule
