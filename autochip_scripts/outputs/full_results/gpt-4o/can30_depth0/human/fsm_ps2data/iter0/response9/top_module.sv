module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;

    // Registers to store received bytes
    reg [7:0] byte1, byte2, byte3;

    // Sequential block for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte1 <= 0;
            byte2 <= 0;
            byte3 <= 0;
            out_bytes <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (next_state == BYTE1) begin
                byte1 <= in;
            end
            if (next_state == BYTE2) begin
                byte2 <= in;
            end
            if (next_state == BYTE3) begin
                byte3 <= in;
            end
            if (state == BYTE3 && next_state == IDLE) begin
                out_bytes <= {byte1, byte2, byte3};
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    // Combinational block for next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
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
