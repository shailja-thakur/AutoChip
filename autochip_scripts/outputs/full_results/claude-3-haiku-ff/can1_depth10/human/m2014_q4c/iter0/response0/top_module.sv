module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

    always_ff @(posedge clk) begin
        if (r) begin
            q <= 1'b0; // Synchronous reset: set q to 0 when r is high
        end
        else begin
            q <= d; // Update q to the value of d on the positive edge of clk
        end
    end

endmodule
