module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_INVERT = 2'b01,
        S_PASS = 2'b10
    } state_t;

    state_t state, next_state;
    reg carry;

    always @(*) begin
        case(state)
            S_IDLE: begin
                if (!areset) next_state = S_INVERT;
                else next_state = S_IDLE;
            end
            
            S_INVERT: begin
                if (areset) next_state = S_IDLE;
                else next_state = S_PASS;
            end
            
            S_PASS: begin
                if (areset) next_state = S_IDLE;
                else next_state = S_PASS;
            end
            
            default: next_state = S_IDLE;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_IDLE;
            carry <= 1'b1;
        end else begin
            state <= next_state;
            case (next_state)
                S_INVERT: begin
                    if (!x) begin
                        z <= 1'b1;
                        carry <= 1'b0;
                    end else begin
                        z <= 1'b0;
                        carry <= 1'b1;
                    end
                end
                
                S_PASS: begin
                    z <= x ^ carry;
                    carry <= carry & x;
                end
            endcase
        end
    end

endmodule
