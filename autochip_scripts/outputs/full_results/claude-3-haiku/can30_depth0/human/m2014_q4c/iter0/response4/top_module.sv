module top_module (
    input clk,
    input d, 
    input r,
    output logic q
);

always_ff @(posedge clk) begin
    if (r) begin
        q <= 1'b0; // Reset the output to 0 on active high synchronous reset
    end
    else begin
        q <= d; // Update the output with the input
    end
end

endmodule
