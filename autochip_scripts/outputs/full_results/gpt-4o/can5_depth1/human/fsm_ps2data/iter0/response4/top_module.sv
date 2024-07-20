module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define states
    typedef enum reg [1:0] {
        IDLE,        // Waiting for in[3] == 1
        BYTE1,       // First byte received
        BYTE2,       // Second byte received
        BYTE3        // Third byte received, ready to mark done
    } state_t;

    state_t curr_state, next_state;
    reg [23:0] buffer;

    // State transition logic
    always @(*) begin
        case (curr_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) begin
            curr_state <= IDLE;
        end else begin
            curr_state <= next_state;
        end
    end

    // Output logic and capture bytes
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'd0;
            buffer <= 24'd0;
            done <= 0;
        end else begin
            case (curr_state)
                IDLE: begin
                    if (in[3] == 1) begin
                        buffer[23:16] <= in;
                    end
                    done <= 0;
                end
                BYTE1: begin
                    buffer[15:8] <= in;
                    done <= 0;
                end
                BYTE2: begin
                    buffer[7:0] <= in;
                    done <= 0;
                end
                BYTE3: begin
                    out_bytes <= buffer;
                    done <= 1;
                end
                default: begin
                    done <= 0;
                end
            endcase
        end
    end

endmodule
