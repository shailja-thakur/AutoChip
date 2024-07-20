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
    
    // State transition and output logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
                out = 1'b0;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
                out = 1'b1;
            end
            default: begin
                next_state = OFF;
                out = 1'b0;
            end
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

endmodule
