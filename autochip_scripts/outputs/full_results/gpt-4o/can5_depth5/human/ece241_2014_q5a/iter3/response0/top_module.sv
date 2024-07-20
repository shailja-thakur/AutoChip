module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01  // Flipping bits state
    } state_t;

    // State variables
    state_t state, next_state;
    reg add_one;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            add_one <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S0: begin
                if (add_one) 
                    next_state = S1;
                else
                    next_state = S1; // Move from initial to flip state
            end
            S1: next_state = S1; // Stay in the flip state
            default: next_state = S0; // Default state
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            add_one <= 1'b1; // set add_one to 1 at reset to start flipping bits
        end else begin
            case (state)
                S0: z <= 1'b0; // Reset output in initial state
                S1: begin
                    if (add_one) begin
                        z <= (x == 1'b1) ? 1'b0 : 1'b1;
                        if (x == 1'b0)
                            add_one <= 1'b0;
                    end else begin
                        z <= x;
                    end
                end
            endcase
        end
    end

endmodule
