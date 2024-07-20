module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

always @(posedge clk) begin
    if (r)
        q <= 1'b0; // Synchronous reset, set q to 0
    else
        q <= d; // Set q to the value of d
end

endmodule
