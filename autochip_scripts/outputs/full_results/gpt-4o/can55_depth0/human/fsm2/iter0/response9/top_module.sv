module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State transition and output logic: Moore machine
    always @(*) begin
        case (state)
            OFF: begin
                out = 1'b0;
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                out = 1'b1;
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: begin
                next_state = OFF;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
endmodule
