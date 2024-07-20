module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Declare state signals
    reg [3:0] state_next;
    reg [3:0] state_reg;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state_reg <= 4'b0; // Reset to initial state A
        end else begin
            state_reg <= state_next; // Update state with next state
        end
    end

    always @(state_reg, x, y) begin
        state_next = state_reg;
        f = 0; // Reset output f
        g = 0; // Reset output g

        case (state_reg)
            4'b0000: // State A
                if (x) begin
                    state_next = 4'b0010; // Transition to state B
                end
            4'b0010: // State B
                state_next = 4'b1000; // Transition to state S0
                f = 1; // Set output f to 1
            4'b1000: // State S0
                if (x) begin
                    state_next = 4'b1001; // Transition to state S1
                end else begin
                    state_next = 4'b1000; // Stay in state S0
                end
            4'b1001: // State S1
                if (x) begin
                    state_next = 4'b1001; // Stay in state S1
                end else begin
                    state_next = 4'b1010; // Transition to state S10
                end
            4'b1010: // State S10
                if (x) begin
                    state_next = 4'b0111; // Transition to state G1
                end else begin
                    state_next = 4'b1000; // Transition to state S0
                end
            4'b0111: // State G1
                if (y) begin
                    state_next = 4'b1011; // Transition to state P1
                    g = 1; // Set output g to 1
                end else begin
                    state_next = 4'b1100; // Transition to state G2
                end
            4'b1100: // State G2
                if (y) begin
                    state_next = 4'b1011; // Transition to state P1
                    g = 1; // Set output g to 1
                end else begin
                    state_next = 4'b1101; // Transition to state P0
                end
            4'b1101: // State P0
                state_next = 4'b1101; // Stay in state P0
            4'b1011: // State P1
                state_next = 4'b1011; // Stay in state P1
        endcase
    end

endmodule
