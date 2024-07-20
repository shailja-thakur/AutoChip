module top_module (
    input d,
    input ena,
    output logic q
);
    always_comb begin
        if (ena) begin
            q = d; // Output port will be equal to the value of the input port when enable port is active
        end else begin
            q = q; // Output port will remain unchanged when enable port is inactive
        end
    end
endmodule
