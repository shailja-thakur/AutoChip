module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // Define states
    typedef enum reg [2:0] {
        IDLE,       // initial state
        ONE,        // seen one '1'
        TWO,        // seen two consecutive '1's
        THREE,      // seen three consecutive '1's
        FOUR,       // seen four consecutive '1's
        FIVE,       // seen five consecutive '1's
        SIX,        // seen six consecutive '1's
        SEVEN       // seen seven or more consecutive '1's
    } state_t;

    state_t state, next;

    // Sequential block: clocked process
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next;
    end

    // Combinational logic block: output and next state logic
    always @(*) begin
        // Initialize outputs
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            IDLE: begin
                if (in)
                    next = ONE;
                else
                    next = IDLE;
            end
            ONE: begin
                if (in)
                    next = TWO;
                else
                    next = IDLE;
            end
            TWO: begin
                if (in)
                    next = THREE;
                else
                    next = IDLE;
            end
            THREE: begin
                if (in)
                    next = FOUR;
                else
                    next = IDLE;
            end
            FOUR: begin
                if (in)
                    next = FIVE;
                else
                    next = IDLE;
            end
            FIVE: begin
                if (in)
                    next = SIX;
                else begin
                    disc = 1;
                    next = IDLE;
                end
            end
            SIX: begin
                if (in) begin
                    next = SEVEN;
                    err = 1;
                end
                else begin
                    flag = 1;
                    next = IDLE;
                end
            end
            SEVEN: begin
                if (in)
                    next = SEVEN;
                else
                    next = IDLE;
            end
            default: next = IDLE; // should not get here
        endcase
    end

endmodule
