module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// internal wires and registers
reg state, next_state;

// sequential logic for state updates
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0;  // reset to state B
    end else begin
        state <= next_state;
    end
end

// combinational logic for next state and output generation
always @* begin
    if (state == 1'b0) begin  // state B
        next_state = (in == 1'b1) ? 1'b0 : 1'b1;
    end else begin  // state A
        next_state = (in == 1'b1) ? 1'b0 : 1'b0;
    end

    out = (state == 1'b0) ? 1'b1 : 1'b0;
end

endmodule
