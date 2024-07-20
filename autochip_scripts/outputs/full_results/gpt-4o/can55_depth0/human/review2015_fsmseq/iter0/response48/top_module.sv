module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        IDLE = 3'd0,
        S1   = 3'd1,
        S11  = 3'd2,
        S110 = 3'd3,
        S1101 = 3'd4
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state; // Default assignment
        case (current_state)
            IDLE: begin
                if (data) 
                    next_state = S1;
            end

            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end

            S11: begin
                if (!data)
                    next_state = S110;
                else
                    next_state = S11;
            end

            S110: begin
                if (data)
                    next_state = S1101;
                else
                    next_state = IDLE;
            end

            S1101: begin
                start_shifting = 1'b1;
            end
        endcase
    end

endmodule
