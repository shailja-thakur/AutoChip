module top_module (
    input [4:1] x,
    output logic f
);

assign f = (x[4:3] == 2'b00 && x[2:1] == 2'b00) ||
          (x[4:3] == 2'b00 && x[2:1] == 2'b11) ||
          (x[4:3] == 2'b11);
endmodule
