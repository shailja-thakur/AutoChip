module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        done = 0;
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE_1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE_1: begin
                next_state = BYTE_2;
            end
            BYTE_2: begin
                next_state = BYTE_3;
            end
            BYTE_3: begin
                done = 1;
                next_state = IDLE; // Return to IDLE to search for the next message
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
