module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: if (x) next_state = S1; else next_state = S0;
            S1: if (x) next_state = S1; else next_state = S2;
            S2: if (x) next_state = S1; else next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            z <= 0;
        end else begin
            case (state)
                S0: z <= 0;
                S1: z <= 0;
                S2: z <= x ? 1 : 0;
            endcase
        end
    end

endmodule
