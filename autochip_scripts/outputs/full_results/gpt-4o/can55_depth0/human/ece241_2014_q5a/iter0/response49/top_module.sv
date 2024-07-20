module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // States
    typedef enum reg [1:0] {
        WAIT = 2'b00,
        INVERT = 2'b01,
        COPY = 2'b10
    } state_t;

    state_t state, next_state;

    // Sequential state transition
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= WAIT;
        else
            state <= next_state;
    end

    // State transition logic
    always @(*) begin
        case (state)
            WAIT: begin
                if (x) 
                    next_state = INVERT;
                else 
                    next_state = COPY;
            end
            
            INVERT: begin
                if (x)
                    next_state = COPY;
                else
                    next_state = INVERT;
            end

            COPY: 
                next_state = COPY;

            default:
                next_state = WAIT;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 0;
        else begin
            case (state)
                WAIT: z <= 0;
                INVERT: z <= ~x;
                COPY: z <= x;
                default: z <= 0;
            endcase
        end
    end

endmodule
