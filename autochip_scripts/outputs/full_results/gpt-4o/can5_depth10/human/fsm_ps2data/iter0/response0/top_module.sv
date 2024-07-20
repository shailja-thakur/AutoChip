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
    reg [7:0] byte1, byte2, byte3;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
        end else begin
            state <= next_state;
            if (done) begin
                out_bytes <= {byte1, byte2, byte3};
            end
            done <= (state == BYTE3);
            if (state == BYTE1 && next_state == BYTE2) byte1 <= in;
            if (state == BYTE2 && next_state == BYTE3) byte2 <= in;
            if (state == BYTE3 && next_state == IDLE) byte3 <= in;
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: if (in[3]) next_state = BYTE1;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
        endcase
    end

endmodule
