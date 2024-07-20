module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    typedef enum reg [1:0] {STATE_IDLE, STATE_INVERT, STATE_PASS} state_t;
    state_t state, next_state;
    
    reg carry;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_IDLE;
            carry <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STATE_IDLE: begin
                if (areset) begin
                    next_state = STATE_IDLE;
                end else begin
                    next_state = STATE_INVERT;
                end
            end
            
            STATE_INVERT: begin
                next_state = STATE_PASS;
            end
            
            STATE_PASS: begin
                next_state = STATE_PASS; // Remain in PASS state
            end
            
            default: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
        end else begin
            case (state)
                STATE_IDLE: begin
                    z <= 0;
                end
                
                STATE_INVERT: begin
                    z <= ~x ^ carry;
                    carry <= ~x | carry;
                end
                
                STATE_PASS: begin
                    z <= x;
                end
            endcase
        end
    end

endmodule
