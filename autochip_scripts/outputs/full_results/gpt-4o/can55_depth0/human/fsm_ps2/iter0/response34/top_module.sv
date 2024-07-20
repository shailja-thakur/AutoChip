module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State declaration
    typedef enum logic [1:0] {
        WAIT_FIRST_BYTE = 2'b00,
        WAIT_SECOND_BYTE = 2'b01,
        WAIT_THIRD_BYTE = 2'b10,
        MESSAGE_RECEIVED = 2'b11
    } state_t;

    state_t state, next_state;

    // Output done should be high for one cycle after third byte is received
    assign done = (state == MESSAGE_RECEIVED);

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FIRST_BYTE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
            WAIT_FIRST_BYTE: begin
                if (in[3]) begin
                    next_state = WAIT_SECOND_BYTE;
                end else begin
                    next_state = WAIT_FIRST_BYTE;
                end
            end
            WAIT_SECOND_BYTE: begin
                next_state = WAIT_THIRD_BYTE;
            end
            WAIT_THIRD_BYTE: begin
                next_state = MESSAGE_RECEIVED;
            end
            MESSAGE_RECEIVED: begin
                next_state = WAIT_FIRST_BYTE;
            end
            default: begin
                next_state = WAIT_FIRST_BYTE;
            end
        endcase
    end

endmodule
