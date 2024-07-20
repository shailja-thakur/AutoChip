module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
    
    // Define the states
    typedef enum logic [3:0] {
        S, S1, S10
    } state_t;
    
    // Define the state and next_state variables
    reg [3:0] state;
    reg [3:0] next_state;
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        case (state)
            S:
                if (x == 0) begin
                    next_state = S;
                end else if (x == 1) begin
                    next_state = S1;
                end
            S1:
                if (x == 0) begin
                    next_state = S10;
                end else if (x == 1) begin
                    next_state = S1;
                end
            S10:
                if (x == 0) begin
                    next_state = S;
                end else if (x == 1) begin
                    next_state = S1;
                end
            default: next_state = S; // Default value if none of the conditions match
        endcase
    end
    
    always_comb begin
        case (state)
            S, S1: z = 0;
            S10: z = x;
        endcase
    end

endmodule
