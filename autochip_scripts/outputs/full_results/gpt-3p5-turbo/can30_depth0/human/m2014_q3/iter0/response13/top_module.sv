module top_module (
    input [4:1] x,
    output logic f
);

logic [3:0] K;
always_comb begin
    case (x[4:1])
        4'b00 : K = 4'b00;
        4'b01 : K = 4'b01;
        4'b11 : K = 4'b11;
        4'b10 : K = 4'b10;
        default : K = 4'b0; // Consider don't-cares as 0
    endcase

    case (K)
        4'b00 : f = 1'b0;
        4'b01 : f = 1'b0;
        4'b11 : f = 1'b1;
        4'b10 : f = 1'b1;
        default : f = 1'b0;
    endcase
end

endmodule
