module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

    always_ff @(posedge clk) begin
        if (r) begin
            q <= 0; // Reset output to 0 if reset is high
        end else begin
            q <= d; // Otherwise, store the value of d
        end
    end

endmodule
