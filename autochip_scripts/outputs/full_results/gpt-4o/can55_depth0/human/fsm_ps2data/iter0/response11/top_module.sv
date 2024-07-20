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

    state_t current_state, next_state;
    reg [23:0] message_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            message_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == IDLE && in[3] == 1) begin
                message_reg[23:16] <= in;
            end else if (current_state == BYTE1) begin
                message_reg[15:8] <= in;
            end else if (current_state == BYTE2) begin
                message_reg[7:0] <= in;
            end

            if (current_state == BYTE3) begin
                out_bytes <= message_reg;
            end
            
            if (current_state == BYTE2 && next_state == BYTE3) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
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
