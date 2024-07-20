module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // One-hot state encoding
    reg state_A, state_B, next_state_A, next_state_B;

    // State transition logic
    always @(*) begin
        case ({state_A, state_B})
            2'b10: begin // Current state A
                if (x) begin
                    next_state_A = 1'b0;
                    next_state_B = 1'b1;
                    z = 1'b1;
                end else begin
                    next_state_A = 1'b1;
                    next_state_B = 1'b0;
                    z = 1'b0;
                end
            end
            2'b01: begin // Current state B
                if (x) begin
                    next_state_A = 1'b0;
                    next_state_B = 1'b1;
                    z = 1'b0;
                end else begin
                    next_state_A = 1'b0;
                    next_state_B = 1'b1;
                    z = 1'b1;
                end
            end
            default: begin // Undefined state
                next_state_A = 1'b1;
                next_state_B = 1'b0;
                z = 1'b0;
            end
        endcase
    end

    // State register logic with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1'b1; // Reset to state A
            state_B <= 1'b0;
        end else begin
            state_A <= next_state_A;
            state_B <= next_state_B;
        end
    end
endmodule
