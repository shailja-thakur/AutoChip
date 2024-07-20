module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg state, next_state;

    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b0;  // reset to state A
        end else begin
            state <= next_state;  // update state
        end
    end

    always @ (*) begin
        case (state)
            1'b0: begin  // state A
                if (j) begin
                    next_state = 1'b1;  // transition to state B
                end else begin
                    next_state = 1'b0;  // stay in state A
                end
            end
            1'b1: begin  // state B
                if (k) begin
                    next_state = 1'b0;  // transition to state A
                end else begin
                    next_state = 1'b1;  // stay in state B
                end
            end
        endcase
    end

    assign out = state;

endmodule
