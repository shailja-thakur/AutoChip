module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State Encoding
    typedef enum logic [3:0] {
        S_IDLE       = 4'b0000,
        S_BIT1       = 4'b0001,
        S_BIT2       = 4'b0010,
        S_BIT3       = 4'b0011,
        S_BIT4       = 4'b0100,
        S_BIT5       = 4'b0101,
        S_BIT6       = 4'b0110,
        S_BIT_DISC   = 4'b0111,
        S_BIT_FLAG   = 4'b1000,
        S_BIT_ERR    = 4'b1001
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always_comb begin
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            S_IDLE: begin
                if (in)
                    next_state = S_BIT1;
                else
                    next_state = S_IDLE;
            end
            S_BIT1: begin
                if (in)
                    next_state = S_BIT2;
                else
                    next_state = S_IDLE;
            end
            S_BIT2: begin
                if (in)
                    next_state = S_BIT3;
                else
                    next_state = S_IDLE;
            end
            S_BIT3: begin
                if (in)
                    next_state = S_BIT4;
                else
                    next_state = S_IDLE;
            end
            S_BIT4: begin
                if (in)
                    next_state = S_BIT5;
                else
                    next_state = S_IDLE;
            end
            S_BIT5: begin
                if (in)
                    next_state = S_BIT6;
                else
                    next_state = S_IDLE;
            end
            S_BIT6: begin
                if (in)
                    next_state = S_BIT_DISC;
                else
                    next_state = S_IDLE;
            end
            S_BIT_DISC: begin
                disc = 1;
                if (in)
                    next_state = S_BIT_FLAG;
                else
                    next_state = S_IDLE;
            end
            S_BIT_FLAG: begin
                flag = 1;
                if (in)
                    next_state = S_BIT_ERR;
                else
                    next_state = S_IDLE;
            end
            S_BIT_ERR: begin
                err = 1;
                next_state = S_IDLE;
            end
            default: next_state = S_IDLE;
        endcase
    end
endmodule
