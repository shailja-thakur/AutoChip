module top_module (
    input d,
    input ena,
    output logic q
);

    // Combinational logic to control the output port
    always_comb begin
        if (ena)
            q = d;
    end

endmodule
