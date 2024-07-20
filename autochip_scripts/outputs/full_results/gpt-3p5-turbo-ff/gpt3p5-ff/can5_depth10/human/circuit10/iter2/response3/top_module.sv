module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_reg;
reg state_reg;

always @(posedge clk) begin
    q_reg <= b;
    state_reg <= ((a & ~b) | (state_reg & ~a)); 
end

// Synchronize the outputs to avoid contention
always @(posedge clk) begin
    q <= q_reg;
    state <= state_reg;
end

endmodule
