module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0001: f = 0;
        4'b1000: f = 1;
        4'b1100: f = 1;
        4'b1110: f = 1;
        4'b1011: f = 1;
        4'b0110: f = 0;
        4'b0100: f = 1;
        4'b0111: f = 1;
        default: f = 0; // Handle the don't-care cases as convenient
    endcase
end

endmodule
