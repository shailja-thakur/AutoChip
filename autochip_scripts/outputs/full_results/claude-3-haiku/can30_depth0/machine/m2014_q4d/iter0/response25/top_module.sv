module top_module (
    input clk,
    input in,
    output logic out
);

// Initialize the output to 0
initial begin
    out = 1'b0;
end

// Toggle the output on the positive edge of the clock
always @(posedge clk) begin
    out <= out ^ in;
end

endmodule
