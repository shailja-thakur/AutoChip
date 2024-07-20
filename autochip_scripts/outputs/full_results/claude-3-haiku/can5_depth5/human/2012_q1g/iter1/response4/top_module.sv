module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    if ((x[4:3] == 2'b00 && x[2:1] == 2'b10) || // 1001
        (x[4:3] == 2'b11)) begin // 1110, 1111, 1101
        f = 1'b1;
    end else begin
        f = 1'b0;
    end
end

endmodule
