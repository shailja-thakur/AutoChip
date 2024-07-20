module top_module (
    input d,
    input ena,
    output logic q
);

    // Internal register to hold the value of q
    logic q_reg;

    // Initial block to initialize q
    initial begin
        q_reg = 0;
    end

    // Combinational logic to control the output q
    always_comb begin
        if (ena) begin
            q_reg = d;
        end
    end

    // Assign the internal register value to output q
    assign q = q_reg;

endmodule
