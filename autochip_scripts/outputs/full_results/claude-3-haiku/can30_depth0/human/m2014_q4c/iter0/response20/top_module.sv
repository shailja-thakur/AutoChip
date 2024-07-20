module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

always_ff @(posedge clk) begin
    if (r) begin
        q <= 1'b0; // Synchronous reset, set q to 0
    end
    else begin
        q <= d; // Normal D flip-flop operation
    end
end

endmodule
