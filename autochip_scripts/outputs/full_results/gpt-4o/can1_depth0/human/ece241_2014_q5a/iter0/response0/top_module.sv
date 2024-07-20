module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_WAIT = 2'b00,
        STATE_INVERT = 2'b01,
        STATE_ADD_ONE = 2'b10
    } state_t;

    state_t current_state, next_state;
    reg carry;

    // State transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WAIT;
            carry <= 0;
            z <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_WAIT: begin
                if (x == 1'b1) begin
                    next_state = STATE_INVERT;
                    z = ~x; // Invert bit
                    carry = 1'b1;
                end else begin
                    next_state = STATE_WAIT;
                    z = x;
                    carry = 0;
                end
            end
        
            STATE_INVERT: begin
                if (x == 1'b1) begin
                    next_state = STATE_ADD_ONE;
                    z = ~x;
                    carry = 1'b1;
                end else begin
                    next_state = STATE_WAIT;
                    z = ~x;
                    carry = 0;
                end
            end

            STATE_ADD_ONE: begin
                if (!carry) begin
                    if (x == 1'b1) begin
                        next_state = STATE_WAIT;
                        z = x;
                        carry = 0;
                    end else begin
                        next_state = STATE_WAIT;
                        z = x;
                        carry = 0;
                    end
                end else begin
                    if (x == 1'b1) begin
                        next_state = STATE_WAIT;
                        z = 0;  // Output become 0 (sum 1+1 +carry 1 = z 0 carry 1)
                        carry = 1;
                    end else begin
                        next_state = STATE_WAIT;
                        z = 1;  // Output become 1 (sum 0+0 +carry 1 = z 1 carry 0)
                        carry = 0;
                    end
                end
            end
        
            default: begin
                next_state = STATE_WAIT;
                z = x;
                carry = 0;
            end
        endcase
    end

endmodule
