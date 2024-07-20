module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State transition logic
always @(*) begin
    case (state)
        1'b0: begin // State A
            if (j) begin
                next_state = 1'b1; // State B
            end else begin
                next_state = 1'b0; // State A
            end
        end
        1'b1: begin // State B
            if (k) begin
                next_state = 1'b0; // State A
            end else begin
                next_state = 1'b1; // State B
            end
        end
        default: begin
            next_state = 1'b0; // State A
        end
    endcase
end

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to State A
    end else begin
        state <= next_state;
    end
end

// Output logic
always @(*) begin
    out = state; // Output the current state
end

endmodule
