module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state, next_state;
wire rising_edge_clk, rising_edge_areset;

/* Detect rising edge of clk */
assign rising_edge_clk = clk & ~state;

/* Detect rising edge of areset */
assign rising_edge_areset = areset & ~state;

always @(posedge clk or posedge areset) begin
    if (rising_edge_areset) begin
        state <= 1'b0;  // Reset to state B
    end else if (rising_edge_clk) begin
        state <= next_state;
    end
end

always @* begin
    if (state == 1'b0) begin  // State B
        if (in == 1'b1) begin
            next_state = 1'b0;  // Next state is B
        end else begin
            next_state = 1'b1;  // Next state is A
        end
    end else begin  // State A
        if (in == 1'b1) begin
            next_state = 1'b1;  // Next state is A
        end else begin
            next_state = 1'b0;  // Next state is B
        end
    end
end

assign out = (state == 1'b0) ? 1'b1 : 1'b0;  // Output is high when state is B, low otherwise

endmodule
