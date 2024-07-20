module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// Combinational logic to determine next state
always @(*) begin
    case (state)
        1'b0: // State A
            if (j) begin
                next_state = 1'b1; // Next state is B
            end else begin
                next_state = 1'b0; // Next state is A
            end
        1'b1: // State B
            if (k) begin
                next_state = 1'b0; // Next state is A
            end else begin
                next_state = 1'b1; // Next state is B
            end
        default:
            next_state = 1'b0; // Default to state A
    endcase
end

// Sequential logic to update state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to state A
    end else begin
        state <= next_state;
    end
end

// Output logic
assign out = state;

endmodule
