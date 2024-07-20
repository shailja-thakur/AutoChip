module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end

            ON: begin
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
            end

            default: next_state = OFF;
        endcase
    end

    // State Register Logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= OFF;
        else 
            state <= next_state;
    end

    // Output Logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            out <= 0;
        else 
            out <= (state == ON);
    end

endmodule
