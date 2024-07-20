module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0,  // Initial state
        S1,  // After seeing 1
        S2   // After seeing 10
    } state_t;
    
    state_t state, next_state;

    // Combinational state transition logic
    always @(*) begin
        case (state)
            S0: if (x) next_state = S1; else next_state = S0;
            S1: if (x) next_state = S1; else next_state = S2;
            S2: if (x) next_state = S1; else next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Sequential state update logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            z <= 0;
        else begin
            case (state)
                S0: z <= 0;
                S1: z <= 0;
                S2: z <= x ? 1 : 0;  // Output 1 when sequence 101 is detected
                default: z <= 0;
            endcase
        end
    end

endmodule
