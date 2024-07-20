module top_module (
    input clk,
    input in,
    output logic out
);

    // Initialize out to 0
    initial begin
        out = 0;
    end

    // Always block to handle the posedge of the clock signal
    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
