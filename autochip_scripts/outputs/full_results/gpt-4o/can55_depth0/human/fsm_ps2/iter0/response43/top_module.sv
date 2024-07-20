module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    // State encoding
    typedef enum logic [1:0] {
        WAIT_FOR_START = 2'b00,
        BYTE2          = 2'b01,
        BYTE3          = 2'b10,
        MESSAGE_DONE   = 2'b11
    } state_t;

    state_t state, next_state;
    logic done_r;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT_FOR_START;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Defaults
        next_state = state;
        done_r = 1'b0;

        case (state)
            WAIT_FOR_START: begin
                if (in[3] == 1) begin
                    next_state = BYTE2;
                end
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = MESSAGE_DONE;
            end

            MESSAGE_DONE: begin
                done_r = 1'b1; // Signal done for one cycle
                next_state = WAIT_FOR_START;
            end
        endcase
    end

    assign done = done_r;

endmodule
