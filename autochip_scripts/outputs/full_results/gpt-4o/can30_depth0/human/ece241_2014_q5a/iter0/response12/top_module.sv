module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State definitions
    typedef enum logic [1:0] {
        S_START     = 2'b00,
        S_FLIP      = 2'b01,
        S_FLIP_DONE = 2'b10
    } state_t;

    state_t state, next_state;
    
    // Moore state machine output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_START;
        end
        else begin
            state <= next_state;
        end
    end

    // Moore state machine next state and output logic
    always @(*) begin
        case (state)
            S_START: begin
                if (areset) begin
                    next_state = S_START;
                    z = 0;
                end
                else begin
                    if (x == 1'b1) begin
                        next_state = S_FLIP;
                        z = 1'b0;
                    end
                    else begin
                        next_state = S_START;
                        z = 1'b0;
                    end
                end
            end
            S_FLIP: begin
                next_state = S_FLIP_DONE;
                z = ~x; // 2's complement step: flip bits
            end
            S_FLIP_DONE: begin
                next_state = S_FLIP_DONE; // stay in this state
                z = x; // pass remaining bits unchanged
            end
            default: begin
                next_state = S_START;
                z = 0;
            end
        endcase
    end
endmodule
