module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state; // Define a 3-bit register to hold the current state

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Reset the state to A
        end else begin
            case (state)
                3'b000: begin // State A
                    if (w) begin
                        state <= 3'b000; // Stay in state A
                    end else begin
                        state <= 3'b001; // Transition to state B
                    end
                end
                3'b001: begin // State B
                    if (w) begin
                        state <= 3'b011; // Transition to state D
                    end else begin
                        state <= 3'b010; // Transition to state C
                    end
                end
                3'b010: begin // State C
                    if (w) begin
                        state <= 3'b011; // Transition to state D
                    end else begin
                        state <= 3'b101; // Transition to state E
                    end
                end
                3'b011: begin // State D
                    if (w) begin
                        state <= 3'b000; // Transition to state A
                    end else begin
                        state <= 3'b110; // Transition to state F
                    end
                end
                3'b101: begin // State E
                    if (w) begin
                        state <= 3'b011; // Transition to state D
                    end else begin
                        state <= 3'b101; // Stay in state E
                    end
                end
                3'b110: begin // State F
                    if (w) begin
                        state <= 3'b011; // Transition to state D
                    end else begin
                        state <= 3'b010; // Transition to state C
                    end
                end
                default: state <= 3'b000; // Default state is A
            endcase
        end
    end

    assign z = (state == 3'b101 || state == 3'b110) ? 1'b1 : 1'b0; // Output z is high in states E and F, low otherwise

endmodule
