module top_module (
    input clk,
    input in,
    output logic out
);

    logic prev_out; // Declare a register to store the previous output

    always_ff @(posedge clk) begin
        prev_out <= out; // Store the previous output
        out <= out ^ in; // Toggle the output based on the current input and previous output
    end

    initial begin
        out = 1'b0; // Initialize the output to 0
    end

endmodule
