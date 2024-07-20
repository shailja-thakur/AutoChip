module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    // Define the states
    typedef enum logic [1:0] {
        OFF,
        ON
    } state_t;
    
    // Declare the state and next state variables
    state_t state, next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
                out = 0;
            end
            
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
                out = 1;
            end
        endcase
    end
endmodule
