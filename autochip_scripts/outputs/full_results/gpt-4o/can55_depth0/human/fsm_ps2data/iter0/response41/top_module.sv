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

    state_t current_state, next_state;
    reg [7:0] byte1, byte2, byte3;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
            out_bytes <= 24'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            done <= 0;
        end else begin
            case (current_state)
                IDLE: begin
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
            endcase
            if (current_state != BYTE3) begin
                done <= 0;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
