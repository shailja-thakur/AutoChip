module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

reg q_reg;

// Positive edge-triggered D flip flop
always @(posedge clk) begin
    if(ar) begin
        q_reg <= 0;  // Asynchronous reset
    end else begin
        q_reg <= d;  // D input
    end
end

assign q = q_reg;

endmodule
