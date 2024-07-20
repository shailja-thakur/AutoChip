module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

// Internal signal to store the flip flop output
logic q_temp;

always_ff @(posedge clk, negedge ar) begin
    if (~ar) begin
        q_temp <= 0; // Reset
    end else begin
        q_temp <= d; // Store the input on the rising edge of the clock
    end
end

assign q = q_temp;

endmodule
