module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Define state encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001, // State after seeing '1'
        S11 = 3'b010, // State after seeing '11'
        S110 = 3'b011, // State after seeing '110'
        FOUND = 3'b100 // State after seeing '1101'
    } state_t;

    state_t state, next_state;

    // Sequential block for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            state <= next_state;
            // Set start_shifting when in the FOUND state
            if (state == FOUND) begin
                start_shifting <= 1'b1;
            end
        end
    end

    // Combinational block for next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data) next_state = S1;
                else next_state = IDLE;
            end
            S1: begin
                if (data) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (!data) next_state = S110;
                else next_state = S11;
            end
            S110: begin
                if (data) next_state = FOUND;
                else next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
