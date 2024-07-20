module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum reg {
        INIT = 1'b0, // Initial state
        COMP = 1'b1  // Complement state
    } state_t;

    // State variables
    state_t state, next_state;

    // Flag to handle flip from the most significant bit (MSB)
    reg flip;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= INIT;
            flip <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            INIT: if (areset) 
                      next_state = INIT;
                  else 
                      next_state = COMP;
            COMP: next_state = COMP;
            default: next_state = INIT; // Default state
        endcase
    end

    // Sequential logic for output and handling 2's complement
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            flip <= 1'b0;
        end else begin
            case (state)
                INIT: begin
                    z <= 1'b0; // No valid output
                    flip <= 1'b0;
                end
                COMP: begin
                    if (!flip && x) begin
                        z <= x;
                        flip <= 1'b1;
                    end else if (flip) begin
                        z <= ~x;
                    end else begin
                        z <= x;
                    end
                end
            endcase
        end
    end

endmodule
