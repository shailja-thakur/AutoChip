module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State declarations
    typedef enum reg [1:0] {
        IDLE,
        BYTE1,
        BYTE2,
        BYTE3
    } state_t;

    state_t state, next_state;

    // Registers to hold the bytes
    reg [7:0] byte1, byte2, byte3;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'bx;
        end
        else begin
            state <= next_state;
            done <= (state == BYTE3);
            if (done) begin
                out_bytes <= {byte1, byte2, byte3};
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE1;
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
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
        end
        else begin
            case (state)
                BYTE1: byte1 <= in;
                BYTE2: byte2 <= in;
                BYTE3: byte3 <= in;
            endcase
        end
    end
endmodule
