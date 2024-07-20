module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Declare states
    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state or zero state.
        S1 = 2'b01,  // State after the first 1 is encountered.
        S2 = 2'b10   // State after the complement is started.
    } state_t;
    
    state_t current_state, next_state;
    reg complement_done;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S0;
            complement_done <= 1'b0;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        case (current_state)
            S0: begin
                if (x == 1'b1) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                next_state = S2;
            end
            S2: begin
                next_state = S2;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end
        else begin
            case (current_state)
                S0: z <= x;
                S1: z <= ~x;
                S2: z <= ~x;
                default: z <= 1'b0;
            endcase
        end
    end
    
endmodule
