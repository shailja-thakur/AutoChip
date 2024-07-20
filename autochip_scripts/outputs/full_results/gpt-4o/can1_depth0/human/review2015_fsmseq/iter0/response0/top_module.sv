module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        S1      = 3'b001,
        S11     = 3'b010,
        S110    = 3'b011,
        S1101   = 3'b100
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        start_shifting = 0;
        case (state)
            IDLE: begin
                if (data) 
                    next_state = S1;
                else 
                    next_state = IDLE;
            end
                
            S1: begin
                if (data) 
                    next_state = S11;
                else 
                    next_state = IDLE;
            end

            S11: begin
                if (data) 
                    next_state = S11;
                else 
                    next_state = S110;
            end

            S110: begin
                if (data) 
                    next_state = S1101;
                else 
                    next_state = IDLE;
            end

            S1101: begin
                start_shifting = 1;
                next_state = S1101;
            end
        endcase
    end
endmodule
