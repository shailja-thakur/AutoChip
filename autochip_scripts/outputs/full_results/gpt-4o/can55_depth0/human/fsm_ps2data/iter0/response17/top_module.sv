module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t state, next_state;

    // Message bytes
    reg [7:0] byte1, byte2, byte3;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:
                if (in[3])
                    next_state = BYTE_1;
                else
                    next_state = IDLE;
                
            BYTE_1:
                next_state = BYTE_2;
                
            BYTE_2:
                next_state = BYTE_3;
                
            BYTE_3:
                next_state = IDLE;
                
            default:
                next_state = IDLE;
        endcase
    end

    // Output logic and state output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            out_bytes <= 24'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 0;
                end
                
                BYTE_1: begin
                    byte1 <= in;
                    done <= 0;
                end
                
                BYTE_2: begin
                    byte2 <= in;
                    done <= 0;
                end
                
                BYTE_3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                end
                
                default: begin
                    done <= 0;
                end
            endcase
        end
    end

endmodule
