module top_module (
    input clk,
    input in,
    output logic out
);

    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

    initial begin
        out <= 1'b0; // Initialize output to 0
    end

endmodule
