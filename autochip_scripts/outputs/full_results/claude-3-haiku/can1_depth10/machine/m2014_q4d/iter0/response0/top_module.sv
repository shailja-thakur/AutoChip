module top_module (
    input clk,
    input in,
    output logic out
);

    // Register to store the previous output
    logic prev_out;

    // Initialize the output to 0
    initial begin
        out = 1'b0;
        prev_out = 1'b0;
    end

    // Toggle the output on every positive edge of the clock
    always @(posedge clk) begin
        prev_out = out;
        out = out ^ in;
    end

endmodule
