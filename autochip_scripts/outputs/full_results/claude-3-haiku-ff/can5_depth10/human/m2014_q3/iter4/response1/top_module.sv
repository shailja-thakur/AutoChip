module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = 0;
    if (x == 4'b0001 || x == 4'b0010 || x == 4'b1100 || x == 4'b1110) begin
        f = 0;
    end
    else if (x == 4'b0101 || x == 4'b1001 || x == 4'b1011) begin
        f = 1;
    end
    else begin
        f = 1;
    end
end

endmodule
