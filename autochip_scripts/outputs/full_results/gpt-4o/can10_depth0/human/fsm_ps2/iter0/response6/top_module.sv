module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

    typedef enum reg [1:0] {WAIT_FOR_BYTE1, BYTE1_RECEIVED, BYTE2_RECEIVED} state_t;
    state_t state, next_state;
    reg [1:0] byte_count;

    // State transition logic
    always @(*) begin
        case(state)
            WAIT_FOR_BYTE1: begin
                if (in[3] == 1)
                    next_state = BYTE1_RECEIVED;
                else
                    next_state = WAIT_FOR_BYTE1;
            end
            BYTE1_RECEIVED: next_state = BYTE2_RECEIVED;
            BYTE2_RECEIVED: next_state = WAIT_FOR_BYTE1;
            default: next_state = WAIT_FOR_BYTE1;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_FOR_BYTE1;
        else
            state <= next_state;
    end

    // Byte counter and output logic
    always @(posedge clk) begin
        if (reset) begin
            byte_count <= 0;
            done <= 0;
        end else begin
            case(state)
                WAIT_FOR_BYTE1: begin
                    done <= 0;
                end
                BYTE1_RECEIVED: begin
                    byte_count <= 1;
                    done <= 0;
                end
                BYTE2_RECEIVED: begin
                    if (byte_count == 2) begin
                        done <= 1;
                    end else begin
                        byte_count <= byte_count + 1;
                        done <= 0;
                    end
                end
            endcase
        end
    end

endmodule
