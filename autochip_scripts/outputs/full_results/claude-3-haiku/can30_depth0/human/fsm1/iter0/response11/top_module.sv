module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b1; // Asynchronously reset to state B
        out <= 1'b1;
    end
    else begin
        case (state)
            1'b0: // State A
                if (in) begin
                    state <= 1'b0; // Transition from A to A
                    out <= 1'b0;
                end
                else begin
                    state <= 1'b1; // Transition from A to B
                    out <= 1'b1;
                end
            1'b1: // State B
                if (in) begin
                    state <= 1'b1; // Transition from B to B
                    out <= 1'b1;
                end
                else begin
                    state <= 1'b0; // Transition from B to A
                    out <= 1'b0;
                end
        endcase
    end
end

endmodule
