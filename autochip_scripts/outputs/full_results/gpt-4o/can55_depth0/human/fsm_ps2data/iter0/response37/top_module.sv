module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
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
                    done <= 0;
                    if (in[3] == 1) begin
                        byte1 <= in;
                    end
                end

                BYTE1: begin
                    byte2 <= in;
                end

                BYTE2: begin
                    byte3 <= in;
                end

                BYTE3: begin
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                end

                default: begin
                    done <= 0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
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
endmodule
