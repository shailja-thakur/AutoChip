module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        FOUND = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition 
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = state;
        
        case (state)
            IDLE: begin
                if (data) next_state = S1;
            end
            S1: begin
                if (data) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (data) next_state = S11;
                else next_state = S110;
            end
            S110: begin
                if (data) next_state = FOUND;
                else next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND;
            end
        endcase

        // Set start_shifting output
        if (state == FOUND) begin
            start_shifting = 1;
        end else begin
            start_shifting = 0;
        end
    end
endmodule
