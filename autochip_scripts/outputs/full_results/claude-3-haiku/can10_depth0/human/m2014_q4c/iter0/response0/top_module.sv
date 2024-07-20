module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

always_ff @(posedge clk) begin
    if (r)
        q <= 1'b0; // Synchronous reset, set q to 0
    else
        q <= d; // D-type flip-flop, assign d to q
end

endmodule
