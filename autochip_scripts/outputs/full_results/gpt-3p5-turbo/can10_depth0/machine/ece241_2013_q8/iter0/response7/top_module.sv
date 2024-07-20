module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define states using an enumerated type
    typedef enum {S, S1, S10} state_t;
    
    // Define registers for current state and next state
    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    // Assign initial state to current state
    initial begin
        curr_state = S;
    end
    
    // Sequential logic for next state calculation
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            curr_state <= S;
        end else begin
            case (curr_state)
                S: begin
                    if (x == 1'b0)
                        next_state <= S;
                    else if (x == 1'b1)
                        next_state <= S1;
                end
                S1: begin
                    if (x == 1'b0)
                        next_state <= S10;
                    else if (x == 1'b1)
                        next_state <= S1;
                end
                S10: begin
                    if (x == 1'b0)
                        next_state <= S;
                    else if (x == 1'b1)
                        next_state <= S1;
                end
                default: next_state <= S; // Default state after reset
            endcase
        end
    end
    
    // Combinational logic for output
    always @(curr_state or x) begin
        case (curr_state)
            S, S1: z = 1'b0;
            S10: z = x;
            default: z = 1'b0; // Default output after reset
        endcase
    end

endmodule
