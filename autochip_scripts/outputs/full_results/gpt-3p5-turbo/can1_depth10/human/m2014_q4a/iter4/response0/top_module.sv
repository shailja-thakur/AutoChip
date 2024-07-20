module top_module (
    input d,
    input ena,
    output logic q
);

    reg q_reg;

    always @(posedge ena, negedge ena) begin
        if (ena) begin
            q_reg <= d;
        end else begin
            q_reg <= q_reg;
        end
    end

    assign q = q_reg;

endmodule
