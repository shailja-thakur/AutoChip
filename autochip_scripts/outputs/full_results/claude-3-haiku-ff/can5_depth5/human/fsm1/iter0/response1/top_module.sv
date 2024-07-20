module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b1; // Reset to state B
    end
    else begin
        case (state)
            1'b0: begin // State A
                if (in) begin
                    state <= 1'b0; // Transition to A
                end
                else begin
                    state <= 1'b1; // Transition to B
                end
            end
            1'b1: begin // State B
                if (in) begin
                    state <= 1'b1; // Transition to B
                end
                else begin
                    state <= 1'b0; // Transition to A
                end
            end
        endcase
    end
end

assign out = ~state; // Output is the complement of the state

endmodule
