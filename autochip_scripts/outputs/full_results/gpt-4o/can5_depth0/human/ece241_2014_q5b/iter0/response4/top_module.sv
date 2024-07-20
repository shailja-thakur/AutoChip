module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {STATE_A = 2'b01, STATE_B = 2'b10} state_t;
    state_t state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;  // Reset to state A
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always_comb begin
        case (state)
            STATE_A: begin
                if (x == 1'b0) begin
                    next_state = STATE_A;
                    z = 1'b0;
                end else begin
                    next_state = STATE_B;
                    z = 1'b1;
                end
            end
            STATE_B: begin
                if (x == 1'b0) begin
                    next_state = STATE_B;
                    z = 1'b1;
                end else begin
                    next_state = STATE_B;
                    z = 1'b0;
                end
            end
            default: begin
                next_state = STATE_A;
                z = 1'b0;
            end
        endcase
    end
endmodule
