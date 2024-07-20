module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001; // Initialize state to A
        end else begin
            case (state)
                3'b001: begin // State A
                    if (x) begin
                        state <= 3'b010; // Transition to B
                    end else begin
                        state <= 3'b001; // Stay in A
                    end
                end
                3'b010: begin // State B
                    if (x) begin
                        state <= 3'b100; // Transition to E
                    end else begin
                        state <= 3'b010; // Stay in B
                    end
                end
                3'b011: begin // State C
                    if (x) begin
                        state <= 3'b010; // Transition to B
                    end else begin
                        state <= 3'b011; // Stay in C
                    end
                end
                3'b100: begin // State D
                    if (x) begin
                        state <= 3'b011; // Transition to C
                    end else begin
                        state <= 3'b010; // Transition to B
                    end
                end
                3'b101: begin // State E
                    if (x) begin
                        state <= 3'b101; // Stay in E
                    end else begin
                        state <= 3'b100; // Transition to D
                    end
                end
                default: begin
                    state <= 3'b001; // If none of the cases match, go back to state A
                end
            endcase
        end
    end

    always @(state) begin
        if (state == 3'b100 || state == 3'b101) begin // Output is high when state is D or E
            z <= 1;
        end else begin
            z <= 0;
        end
    end

endmodule
