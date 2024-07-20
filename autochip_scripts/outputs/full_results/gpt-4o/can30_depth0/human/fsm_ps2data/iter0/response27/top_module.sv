module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] byte1, byte2, byte3;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        byte1 <= in;
                        done <= 0;
                    end
                end
                BYTE1: byte2 <= in;
                BYTE2: byte3 <= in;
                BYTE3: begin
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                end
                default: done <= 0;
            endcase
            
            if (state != BYTE3) begin
                done <= 0;
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: if (in[3] == 1'b1) next_state = BYTE1;
                  else next_state = IDLE;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
endmodule
