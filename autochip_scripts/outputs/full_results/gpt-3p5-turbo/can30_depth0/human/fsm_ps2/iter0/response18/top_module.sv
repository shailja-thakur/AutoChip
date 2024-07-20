module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Define states
    typedef enum logic [2:0] {
        STATE_IDLE,
        STATE_BYTE_1,
        STATE_BYTE_2,
        STATE_BYTE_3
    } state_t;

    // Declare internal signals
    reg done;
    reg [2:0] state;

    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
            state <= STATE_IDLE;
        end else begin
            case (state)
                STATE_IDLE:
                    if (in[3]) begin
                        state <= STATE_BYTE_1;
                    end
                STATE_BYTE_1:
                    state <= STATE_BYTE_2;
                STATE_BYTE_2:
                    state <= STATE_BYTE_3;
                STATE_BYTE_3:
                    begin
                        state <= STATE_IDLE;
                        done <= 1;
                    end
            endcase
        end
    end

endmodule
