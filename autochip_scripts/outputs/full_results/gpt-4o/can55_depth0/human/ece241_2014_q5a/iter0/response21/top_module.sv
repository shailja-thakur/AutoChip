module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding
    typedef enum logic [1:0] {
        S_IDLE = 2'b00,  // Idle state
        S_FLIP = 2'b01,  // State to flip the bits
        S_COMPLEMENT = 2'b10 // State to handle adding 1 for two's complement
    } state_t;

    state_t current_state, next_state;
    logic flip_bit;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S_IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S_IDLE: next_state = S_FLIP; // Once reset is released, go to flipping state
            S_FLIP: next_state = S_COMPLEMENT; // After flipping, go to complement state
            S_COMPLEMENT: next_state = S_COMPLEMENT; // Stay in complement state
            default: next_state = S_IDLE;
        endcase
    end

    // Output and flip bit logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            flip_bit <= 0;
        end
        else begin
            case (current_state)
                S_IDLE: begin
                    z <= 0;
                    flip_bit <= 0;
                end
                S_FLIP: begin
                    z <= ~x; // Flip the bit
                    flip_bit <= 1; // Indicate to start adding 1 for two's complement
                end
                S_COMPLEMENT: begin
                    if (flip_bit) begin
                        if (~x) begin // Check carry for addition
                            z <= 1;
                            flip_bit <= 0;
                        end
                        else begin
                            z <= 0;
                        end
                    end
                    else begin
                        z <= x;
                    end
                end
            endcase
        end
    end
endmodule
