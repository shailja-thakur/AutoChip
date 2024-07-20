module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [23:0] buffer;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            buffer <= 24'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE1) buffer[23:16] <= in;
            if (current_state == BYTE2) buffer[15:8]  <= in;
            if (current_state == BYTE3) buffer[7:0]   <= in;
            if (current_state == BYTE3) out_bytes <= buffer;
            if (current_state == BYTE3) done <= 1;
            else done <= 0;
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: if (in[3]) next_state = BYTE1;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
        endcase
    end

endmodule
