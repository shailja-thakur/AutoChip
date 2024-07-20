module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    case (state)
        1'b0: begin // Initial state
            p <= 0;
            q <= 0;
            if (a == 1'b0) begin
                state <= 1'b0; // Stay in state 0
            end else begin
                state <= 1'b1; // Transition to state 1
            end
        end
        1'b1: begin // State 1
            p <= 0;
            q <= 1;
            if (a == 1'b0) begin
                state <= 1'b0; // Transition to state 0
            end else begin
                state <= 1'b1; // Stay in state 1
            end
        end
        default: begin
            state <= 1'b0; // Reset to initial state
        end
    endcase
end

endmodule
