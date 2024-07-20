module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    typedef enum logic [2:0] {IDLE, START, DATA, STOP} fsm_state;

    reg [2:0] state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            IDLE:
                if (in == 1'b0)
                    next_state = START;
                else
                    next_state = IDLE;
            START:
                next_state = DATA;
            DATA:
                if (in == 1'b1)
                    next_state = STOP;
                else
                    next_state = DATA;
            STOP:
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = STOP;
        endcase
    end

    assign done = (state == STOP);

endmodule
