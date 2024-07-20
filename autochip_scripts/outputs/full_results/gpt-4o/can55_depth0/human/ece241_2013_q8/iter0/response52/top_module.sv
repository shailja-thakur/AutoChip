module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state
        S1 = 2'b01,  // State after first '1'
        S2 = 2'b10   // State after '10'
    } state_t;
    
    state_t state, next_state;
    
    // State transition and output logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;  // Asynchronous reset
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            S0: begin
                if (x) 
                    next_state = S1;
                else 
                    next_state = S0;
                z = 0;
            end
            S1: begin
                if (x) 
                    next_state = S1;
                else 
                    next_state = S2;
                z = 0;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1;  // Sequence 101 detected
                end
                else begin
                    next_state = S0;
                    z = 0;
                end
            end
            default: begin
                next_state = S0;
                z = 0;
            end
        endcase
    end
endmodule
