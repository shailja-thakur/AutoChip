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
            S0: next_state = S1; // Move from initial to flip state
            S1: next_state = S1; // Stay in the flip state
            default: next_state = S0; // Default state
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            add_one <= 1'b0;
        end else begin
            case (state)
                S0: begin
                    z <= 1'b0;
                    add_one <= 1'b0;
                end
                S1: begin
                    if (add_one) begin
                        if (x == 1'b0) begin
                            z <= 1'b1;
                            add_one <= 1'b0;
                        end else begin
                            z <= 1'b0;
                        end
                    end else begin
                        z <= ~x;
                        if (x == 1'b1) begin
                            add_one <= 1'b1;
                        end
                    end
                end
            endcase
        end
    end

endmodule
