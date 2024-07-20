module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state;
reg next_state;

// State machine logic
always @(posedge clk) begin
    if (areset) begin
        state <= 1'b0; // Reset to state B
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        1'b0: // state B
            if (in) begin
                next_state = 1'b0; // Next state is B
            end else begin
                next_state = 1'b1; // Next state is A
            end
        1'b1: // state A
            if (in) begin
                next_state = 1'b1; // Next state is A
            end else begin
                next_state = 1'b0; // Next state is B
            end
    endcase
end

// Output logic
assign out = (state == 1'b0);

endmodule
