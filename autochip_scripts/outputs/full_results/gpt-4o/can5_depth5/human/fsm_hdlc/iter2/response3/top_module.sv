module top_module(
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S0   = 3'b001,  // 0
        S1   = 3'b010,  // 01
        S2   = 3'b011,  // 011
        S3   = 3'b100,  // 0111
        S4   = 3'b101,  // 01111
        S5   = 3'b110,  // 011111
        S6   = 3'b111   // 0111111
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = S0;
                else
                    next_state = IDLE;
            end
            S0: begin
                if (in)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (in)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (in)
                    next_state = S4;
                else
                    next_state = S0;
            end
            S4: begin
                if (in)
                    next_state = S5;
                else
                    next_state = S0;
            end
            S5: begin
                if (in)
                    next_state = S6;
                else begin
                    disc = 1'b1;
                    next_state = S0;
                end
            end
            S6: begin
                if (in) begin
                    err = 1'b1;
                    next_state = IDLE;  // Error state, go back to idle
                end else begin
                    flag = 1'b1;
                    next_state = S0;
                end
            end
        endcase
    end
endmodule
