module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        S1   = 2'b01,
        S10  = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (x)
                    next_state = S1;
                else
                    next_state = IDLE;
            end

            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S10;
            end

            S10: begin
                if (x)
                    next_state = S1;
                else
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // State register
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            z <= 0;
        else begin
            case (state)
                IDLE: z <= 0;
                S1: z <= 0;
                S10: z <= x ? 1 : 0;
                default: z <= 0;
            endcase
        end
    end

endmodule
