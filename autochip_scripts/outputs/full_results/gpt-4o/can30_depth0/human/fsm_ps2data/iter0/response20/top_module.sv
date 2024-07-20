module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] temp_bytes;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and storing bytes
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            out_bytes <= 24'd0;
            temp_bytes <= 24'd0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (in[3] == 1) begin
                        temp_bytes[23:16] <= in;
                    end
                end
                BYTE1: temp_bytes[15:8] <= in;
                BYTE2: temp_bytes[7:0] <= in;
                BYTE3: begin
                    out_bytes <= temp_bytes;
                    done <= 1;
                end
                default: begin
                    done <= 0;
                    temp_bytes <= 24'd0;
                end
            endcase
        end
    end

endmodule
