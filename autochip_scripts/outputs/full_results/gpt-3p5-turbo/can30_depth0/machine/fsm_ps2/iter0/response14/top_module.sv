module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State definitions
    typedef enum logic [1:0] {
        BYTE1,
        BYTE2,
        BYTE3,
        DONE
    } state_t;

    // State register
    reg state_t current_state, next_state;

    // Next state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition and output logic
    always @(current_state, in) begin
        case (current_state)
            BYTE1:
                if (in[2]) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            BYTE2:
                next_state = BYTE3;
            BYTE3:
                next_state = DONE;
            DONE:
                if (in[2]) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
        endcase
    end

    // Output logic
    always @(current_state) begin
        done = (current_state == DONE);
    end

endmodule
