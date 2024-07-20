module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding in one-hot
    reg state_A, state_B;
    
    // State transition on rising edge of clk or active-high async reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1'b1;
            state_B <= 1'b0;
        end else begin
            case ({state_A, state_B})
                2'b10: begin // State A
                    if (x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end else begin
                        state_A <= 1'b1;
                        state_B <= 1'b0;
                    end
                end
                2'b01: begin // State B
                    if (x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end else begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end
                end
                default: begin // Should never happen as we are using one-hot encoding
                    state_A <= 1'b1;
                    state_B <= 1'b0;
                end
            endcase
        end
    end

    // Output logic based on current state and input x
    always @(*) begin
        case ({state_A, state_B})
            2'b10: z = x;      // State A
            2'b01: z = ~x;     // State B
            default: z = 1'b0; // Should never happen as we are using one-hot encoding
        endcase
    end

endmodule
