module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define state names
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON = 2'b01
    } state_t;
    
    // Current and next state variables
    state_t current_state, next_state;
    
    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Combinational logic for next state and output
    always @(*) begin
        case (current_state)
            OFF: begin
                out = 1'b0;
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                out = 1'b1;
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF;
            end
        endcase
    end
endmodule
