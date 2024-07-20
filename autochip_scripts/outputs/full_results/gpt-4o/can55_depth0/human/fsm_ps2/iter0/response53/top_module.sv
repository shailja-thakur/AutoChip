module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State declarations
    typedef enum reg [1:0] {
        WAIT_BYTE1 = 2'd0,
        RECEIVED_BYTE1 = 2'd1,
        RECEIVED_BYTE2 = 2'd2,
        MESSAGE_DONE = 2'd3
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        done = 1'b0;  // Default output
        case (state)
            WAIT_BYTE1: begin
                if (in[3] == 1)
                    next_state = RECEIVED_BYTE1;
                else
                    next_state = WAIT_BYTE1;
            end
            
            RECEIVED_BYTE1: begin
                next_state = RECEIVED_BYTE2;
            end
            
            RECEIVED_BYTE2: begin
                next_state = MESSAGE_DONE;
            end
            
            MESSAGE_DONE: begin
                done = 1'b1;
                if (in[3] == 1)
                    next_state = RECEIVED_BYTE1;
                else
                    next_state = WAIT_BYTE1;
            end
            
            default: next_state = WAIT_BYTE1;
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_BYTE1;
        end else begin
            state <= next_state;
        end
    end
endmodule
