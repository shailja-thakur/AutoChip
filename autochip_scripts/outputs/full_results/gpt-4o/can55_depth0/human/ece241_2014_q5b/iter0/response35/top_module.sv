module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg state_A, state_B;

    // State transition on clock edge or asynchronous reset
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            // on reset, go to state A
            state_A <= 1;
            state_B <= 0;
        end else begin
            // state transitions based on current state and input x
            case ({state_A, state_B})
                2'b10: begin // state A
                    if (x) begin
                        state_A <= 0;
                        state_B <= 1;
                    end else begin
                        state_A <= 1;
                        state_B <= 0;
                    end
                end
                2'b01: begin // state B
                    if (x) begin
                        state_A <= 0;
                        state_B <= 1;
                    end else begin
                        state_A <= 0;
                        state_B <= 1;
                    end
                end
                default: begin // should never happen
                    state_A <= 1;
                    state_B <= 0;
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case ({state_A, state_B})
            2'b10: z = x ? 1'b1 : 1'b0; // state A
            2'b01: z = x ? 1'b0 : 1'b1; // state B
            default: z = 1'b0; // default case, should never happen
        endcase
    end
endmodule
