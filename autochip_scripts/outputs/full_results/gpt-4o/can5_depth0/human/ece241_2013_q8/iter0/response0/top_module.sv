module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // Detected '1'
        S2 = 2'b10  // Detected '10'
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S2: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    // State update logic (sequential)
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S0: z = 0;
            S1: z = 0;
            S2: z = (x == 1) ? 1 : 0;
            default: z = 0;
        endcase
    end
endmodule
