module top_module (
	input [4:1] x,
	output logic f
);
 
always_comb begin
    case (x)
        4'b00??: f = 1'b1;
        4'b01??: f = x[1] & ~x[2];
        4'b10??: f = x[1];
        4'b11??: f = x[1] | x[2];
    endcase
end

endmodule
