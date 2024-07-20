module top_module (
    input clk,
    input in,
    output logic out
);

    // Initial value of out
    initial begin
        out = 0;
    end

    // Toggle flip-flop logic on the posedge of clk
    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
