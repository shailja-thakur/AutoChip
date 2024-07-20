module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

always_ff @(posedge clk) begin
    if (r)
        q <= 1'b0; // Reset the output to 0 on active high synchronous reset
    else
        q <= d; // Update the output with the input d
end

endmodule
