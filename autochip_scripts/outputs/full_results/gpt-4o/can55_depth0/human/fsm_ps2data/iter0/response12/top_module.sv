module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {
        STATE_IDLE,
        STATE_BYTE1,
        STATE_BYTE2,
        STATE_BYTE3
    } state_t;

    state_t state, next_state;
    reg [23:0] byte_buffer;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
            byte_buffer <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            done <= 1'b0;   // Default value of done signal
            if (state == STATE_BYTE3) begin
                out_bytes <= byte_buffer;
                done <= 1'b1;
            end
        end
    end

    always @(*) begin
        next_state = state;
        
        case (state)
            STATE_IDLE: begin
                if (in[3] == 1'b1)
                    next_state = STATE_BYTE1;
            end

            STATE_BYTE1: begin
                next_state = STATE_BYTE2;
            end

            STATE_BYTE2: begin
                next_state = STATE_BYTE3;
            end

            STATE_BYTE3: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            byte_buffer <= 24'b0;
        end
        else begin
            case (state)
                STATE_BYTE1: byte_buffer[23:16] <= in;
                STATE_BYTE2: byte_buffer[15:8]  <= in;
                STATE_BYTE3: byte_buffer[7:0]   <= in;
            endcase
        end
    end
endmodule
