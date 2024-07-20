module top_module (
    input clk,
    input in,
    output logic out
);
    // Declare a reg to store the previous value of out
    reg prev_out;

    always_ff @(posedge clk) begin
        // Update the previous out value
        prev_out <= out;
        
        // Update the output value
        out <= in ^ prev_out;
    end
endmodule
