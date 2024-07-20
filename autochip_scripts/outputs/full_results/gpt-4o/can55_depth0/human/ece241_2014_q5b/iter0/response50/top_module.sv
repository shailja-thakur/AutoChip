module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // State encoding using one-hot encoding
    reg state_A, state_B;

    // Next state logic
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1;
            state_B <= 0;
        end
        else begin
            case ({state_A, state_B})
                2'b10: begin // State A
                    if (x) begin
                        state_A <= 0;
                        state_B <= 1;
                    end else begin
                        state_A <= 1;
                        state_B <= 0;
                    end
                end
                2'b01: begin // State B
                    state_A <= 0;
                    state_B <= 1;
                end
            endcase
        end
    end

    // Output logic
    assign z = (state_A && x) || (state_B && !x);

endmodule
