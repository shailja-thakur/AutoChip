module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define the States using an enumerated type
    typedef enum logic [1:0] {
        S_INIT = 2'b00,   // Initial state
        S_COMP = 2'b01,   // Complement state
        S_END  = 2'b10    // End state (optional, can be used for more complex control)
    } state_t;

    state_t current_state, next_state;
    reg complement_bit;
    
    // State Register
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S_INIT;
            z <= 0;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next State Logic and Output Logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        z = complement_bit;

        case (current_state)
            S_INIT: begin
                complement_bit = 0;
                if (!areset) begin
                    next_state = S_COMP;
                end
            end
            S_COMP: begin
                complement_bit = ~x;
                next_state = S_COMP;
            end
            default: begin
                next_state = S_INIT;
            end
        endcase
    end

    // Output Logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
        end
        else begin
            z <= complement_bit;
        end
    end
endmodule
