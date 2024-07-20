module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    // State declarations
    typedef enum reg [1:0] {OFF = 2'b00, ON = 2'b01} state_t;
    state_t state, next_state;
    
    // State transition based on inputs
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end
            ON: begin
                if (k == 1)
                    next_state = OFF;
                else 
                    next_state = ON;
            end
            default: 
                next_state = OFF;
        endcase
    end
    
    // State register with asynchronous active high reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Output logic: Moore machine outputs depend on the state only
    always @(state) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
    
endmodule
