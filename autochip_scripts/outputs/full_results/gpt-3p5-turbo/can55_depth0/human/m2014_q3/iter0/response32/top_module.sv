module top_module (
    input [4:1] x,
    output logic f
);

// Karnaugh map
always_comb begin
    case (x[4:1])
        4'b0000: f = 0;  //00
        4'b0001: f = 1;  //01
        4'b0010: f = 0;  //10
        4'b0011: f = 1;  //11
        4'b0100: f = 0;  //00
        4'b0101: f = x[3];  //01
        4'b0110: f = 1;  //10
        4'b0111: f = 1;  //11
        4'b1000: f = 1;  //00
        4'b1001: f = 0;  //01
        4'b1010: f = x[3];  //10
        4'b1011: f = x[3];  //11
        4'b1100: f = 0;  //00
        4'b1101: f = 1;  //01
        4'b1110: f = x[3];  //10
        4'b1111: f = x[3];  //11
    endcase
end

endmodule
