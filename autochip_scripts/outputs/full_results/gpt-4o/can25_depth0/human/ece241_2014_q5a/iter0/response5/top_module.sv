module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        INVERTING = 2'b01,
        ADDING_ONE = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg carry;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            carry <= 1'b0;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        case (state)
            IDLE: begin
                if (!areset)
                    next_state = INVERTING;
                else
                    next_state = IDLE;
            end
            INVERTING: begin
                if (!areset)
                    next_state = ADDING_ONE;
                else
                    next_state = INVERTING;
            end
            ADDING_ONE: begin
                if (!areset)
                    next_state = ADDING_ONE;
                else
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            carry <= 1'b0;
        end else begin
            case (state)
                INVERTING: begin
                    z <= ~x;
                    carry <= 1'b1;  
                end
                ADDING_ONE: begin
                    z <= ~x ^ carry;
                    carry <= carry & ~x;
                end
                default: z <= 1'b0;
            endcase
        end
    end

endmodule
