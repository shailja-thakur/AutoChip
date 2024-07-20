module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    enum {WAIT_BYTE1, BYTE1, BYTE2, BYTE3} fsm_state;

    // State Transition
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_BYTE1;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        next_state = state;
        done = 0;
        
        case (state)
            WAIT_BYTE1: begin
                if (in[3])
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = WAIT_BYTE1;
                done = 1;
            end
            default: next_state = WAIT_BYTE1;
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'd0;
        end else if (state == BYTE1) begin
            out_bytes[23:16] <= in;
        end else if (state == BYTE2) begin
            out_bytes[15:8] <= in;
        end else if (state == BYTE3) begin
            out_bytes[7:0] <= in;
        end
    end

endmodule
