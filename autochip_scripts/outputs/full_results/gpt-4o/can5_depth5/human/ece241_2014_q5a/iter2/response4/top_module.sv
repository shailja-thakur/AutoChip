module top_module(
    input clk,
    input areset,
    input x,
    output reg z
);

    // State definitions
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01  // Flipping state
    } state_t;

    // State and temp variable
    state_t state, next_state;
    reg flip;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            flip <= 1'b0;
        end 
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = S1; 
            S1: next_state = S1;
            default: next_state = S0;
        endcase
    end

    // Output logic and operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            flip <= 1'b0;
        end 
        else begin
            case (state)
                S0: begin
                    z <= x; // Start with the same bit
                    flip <= 1'b1; // Start flipping
                end
                S1: begin
                    if(flip) begin
                        z <= ~x; // Flip bit
                        flip <= 1'b0; // Turn off flip to add 1
                    end
                    else begin
                        z <= z + 1'b1; // Add 1 to get 2's complement
                        flip <= 1'b1; // Turn on flip for next bit
                    end
                end
            endcase
        end
    end
endmodule
