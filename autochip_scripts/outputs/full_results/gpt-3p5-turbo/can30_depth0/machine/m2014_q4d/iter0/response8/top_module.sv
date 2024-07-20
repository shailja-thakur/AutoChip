module top_module (
    input clk,
    input in,
    output logic out
);

    // Define a signal to hold the previous value of the output
    logic prev_out;
    
    always_ff @(posedge clk) begin
        prev_out <= out; // Save the current value of out as previous value
        out <= in ^ prev_out; // Toggle the output based on input and previous output
    end

endmodule
