module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        IDLE       = 2'b00,
        DETECT_ONE = 2'b01,
        INVERT     = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (x)
                    next_state = DETECT_ONE;
                else
                    next_state = IDLE;
            end
            DETECT_ONE: begin
                next_state = INVERT;
            end
            INVERT: begin
                if (areset)
                    next_state = IDLE;
                else
                    next_state = INVERT;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 1'b0;
        else begin
            case (current_state)
                IDLE: z <= x; // initial bit is passed as is
                DETECT_ONE: z <= ~x; // Invert x after detecting the first 1
                INVERT: z <= ~x; // Continue inverting x
                default: z <= 1'b0; // default state
            endcase
        end
    end

endmodule
