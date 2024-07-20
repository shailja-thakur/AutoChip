module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State definitions
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Combinatorial logic for next state and output
    always_comb begin
        // Default values
        next_state = state;
        done = 1'b0;

        case(state)
            BYTE1: begin
                if (in[2]) begin
                    next_state = BYTE2;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1; // Assert done signal
                if (~in[2]) begin
                    next_state = BYTE1;
                end else begin
                    next_state = BYTE2;
                end
            end
        endcase
    end

endmodule
