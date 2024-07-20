module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    
    // Define states
    typedef enum logic [1:0] {
        S,
        S1,
        S10
    } state_t;
    
    // Define current state and next state variables
    reg state_t current_state;
    reg state_t next_state;
    
    // Synchronous state update process
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            current_state <= S;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Combinational logic for next state and output generation
    always @* begin
        case (current_state)
            S: begin
                if (x == 0) begin
                    next_state = S;
                    z = 0;
                end else begin
                    next_state = S1;
                    z = 0;
                end
            end
            
            S1: begin
                if (x == 0) begin
                    next_state = S10;
                    z = 0;
                end else begin
                    next_state = S1;
                    z = 0;
                end
            end
            
            S10: begin
                if (x == 0) begin
                    next_state = S;
                    z = 0;
                end else begin
                    next_state = S1;
                    z = x;
                end
            end
            
            default: begin
                next_state = S;
                z = 0;
            end
        endcase
    end
endmodule
