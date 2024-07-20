module top_module (
    input clk,
    input in,
    output logic out
);

    // Initialize the output signal to 0
    initial begin
        out = 1'b0;
    end

    // Toggle the output signal on positive edge of clock
    always @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
