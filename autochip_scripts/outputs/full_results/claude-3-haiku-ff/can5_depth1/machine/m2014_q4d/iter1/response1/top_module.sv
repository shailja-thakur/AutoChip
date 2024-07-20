module top_module (
    input clk,
    input in,
    output logic out
);

    initial begin
        out = 1'b0; // Initialize the output to 0
    end

    always_ff @(posedge clk) begin
        out <= out ^ in; // Toggle the output based on the XOR of the input and previous output
    end

endmodule
