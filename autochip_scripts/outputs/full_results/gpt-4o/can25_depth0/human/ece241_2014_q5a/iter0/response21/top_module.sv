module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'd0,
        ONE = 2'd1, // Inverting stage
        TWO = 2'd2, // Adding one stage
        OUTPUT = 2'd3
    } state_t;
    
    state_t state, next_state;
    reg carry; // To keep track of carry during addition

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            z <= 1'b0;
            carry <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    z <= 1'b0;
                    carry <= 1'b0;
                end
                ONE: begin
                    z <= ~x;
                end
                TWO: begin
                    z <= x ^ carry;
                    carry <= x & carry;
                end
                OUTPUT: begin
                    z <= z; // Maintain z value
                end
            endcase
        end
    end
    
    always_comb begin
        case (state)
            IDLE:
                if (areset)
                    next_state = IDLE;
                else
                    next_state = ONE;
            ONE:
                next_state = TWO;
            TWO:
                next_state = OUTPUT;
            OUTPUT:
                if (areset)
                    next_state = IDLE;
                else 
                    next_state = OUTPUT;
            default: 
                next_state = IDLE;
        endcase
    end
    
endmodule
