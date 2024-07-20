module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State declaration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        FLIP = 2'b01,
        OUTPUT = 2'b10
    } state_t;
    
    // Current state and next state variables
    state_t state, next_state;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Combinational logic for next state
    always @(*) begin
        case (state)
            IDLE: next_state = FLIP;
            FLIP: next_state = x ? OUTPUT : FLIP;
            OUTPUT: next_state = OUTPUT;
            default: next_state = IDLE;
        endcase
    end
    
    // Combinational logic for output
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end 
        else begin
            case (state)
                IDLE: begin
                    z <= 1'b0;
                end
                FLIP: begin
                    z <= ~x;
                end
                OUTPUT: begin
                    z <= z;
                end
            endcase
        end
    end
    
endmodule
