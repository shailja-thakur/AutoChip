module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Output logic
    assign done = (current_state == DONE);

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            BYTE1: begin
                if (in[2]) // Check the third bit of the input
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (in[2]) // Check the third bit of the input
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            default: begin
                next_state = BYTE1; // Default state
            end
        endcase
    end

endmodule
