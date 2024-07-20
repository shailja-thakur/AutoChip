module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        WAIT_FOR_FIRST_BYTE = 2'b00,
        BYTE_1_RECEIVED = 2'b01,
        BYTE_2_RECEIVED = 2'b10,
        BYTE_3_RECEIVED = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] message;
    
    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_FIRST_BYTE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (done) begin
                out_bytes <= message;
                done <= 1'b0;
            end
            else begin
                done <= (state == BYTE_3_RECEIVED);
            end
        end
    end
    
    // Next state logic and message capturing
    always_comb begin
        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3]) begin
                    next_state = BYTE_1_RECEIVED;
                    message[23:16] = in;
                end
                else begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                end
            end

            BYTE_1_RECEIVED: begin
                next_state = BYTE_2_RECEIVED;
                message[15:8] = in;
            end

            BYTE_2_RECEIVED: begin
                next_state = BYTE_3_RECEIVED;
                message[7:0] = in;
            end

            BYTE_3_RECEIVED: begin
                next_state = WAIT_FOR_FIRST_BYTE;
            end

            default: next_state = WAIT_FOR_FIRST_BYTE;
        endcase
    end

endmodule
