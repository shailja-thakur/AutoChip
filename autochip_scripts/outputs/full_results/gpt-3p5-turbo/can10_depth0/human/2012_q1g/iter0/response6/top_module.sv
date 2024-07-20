module top_module (
    input [4:1] x,
    output logic f
);

assign f = (x[3:2] == 2'b00 && x[1:0] == 2'b00) || 
           (x[3:2] == 2'b00 && x[1:0] == 2'b10) || 
           (x[3:2] == 2'b10 && x[1:0] == 2'b00) || 
           (x[3:2] == 2'b10 && x[1:0] == 2'b01) || 
           (x[3:2] == 2'b10 && x[1:0] == 2'b10);

endmodule
