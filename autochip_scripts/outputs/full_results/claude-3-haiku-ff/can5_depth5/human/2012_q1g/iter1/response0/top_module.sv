module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    if ((x[4] == 1'b0) && (x[3] == 1'b1)) begin
        f = 1'b1;
    end else if ((x[3] == 1'b0) && (x[2] == 1'b0) && (x[1] == 1'b0)) begin
        f = 1'b1;
    end else if ((x[4] == 1'b1) && (x[3] == 1'b1) && (x[2] == 1'b1)) begin
        f = 1'b1;
    end else if ((x[4] == 1'b1) && (x[2] == 1'b1) && (x[1] == 1'b0)) begin
        f = 1'b1;
    end else begin
        f = 1'b0;
    end
end

endmodule
