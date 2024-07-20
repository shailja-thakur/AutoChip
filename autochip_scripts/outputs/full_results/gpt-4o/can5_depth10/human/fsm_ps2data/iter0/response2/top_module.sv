module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State definition
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] byte1, byte2, byte3;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'bx;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (!reset) begin
            case (state)
                IDLE: begin
                    if (in[3]) begin
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
        end
    end

    always_comb begin
        next_state = state;

        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: begin
                next_state = IDLE;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if (state == BYTE3) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule
