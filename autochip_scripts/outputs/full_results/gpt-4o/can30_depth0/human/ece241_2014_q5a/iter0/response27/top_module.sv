module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_IDLE = 2'b00,
        STATE_INVERT = 2'b01,
        STATE_ADD1 = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg carry;

    // State transition
    always @(*) begin
        case (state)
            STATE_IDLE: begin
                if (x == 1'b1)
                    next_state = STATE_INVERT;
                else
                    next_state = STATE_IDLE;
            end
            STATE_INVERT: begin
                next_state = STATE_ADD1;
            end
            STATE_ADD1: begin
                if (carry) 
                    next_state = STATE_ADD1;
                else 
                    next_state = STATE_INVERT;
            end
            default: next_state = STATE_IDLE;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= STATE_IDLE;
        else 
            state <= next_state;
    end
    
    // Output logic and carry handling
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            carry <= 0;
        end else begin
            case (state)
                STATE_IDLE: begin
                    z <= 0;
                    carry <= 0;
                end
                STATE_INVERT: begin
                    z <= ~x;
                    carry <= 1'b0;
                end
                STATE_ADD1: begin
                    {carry, z} <= {carry, ~x} + 1;
                end
            endcase
        end
    end

endmodule
