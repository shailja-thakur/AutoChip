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
    reg [23:0] data_reg;

    // Sequential block for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
            if (next_state == BYTE3) begin
                data_reg[7:0] <= in;
                out_bytes <= {data_reg[23:8], in};
                done <= 1;
            end else if (next_state == IDLE) begin
                out_bytes <= 24'b0;
                done <= 0;
            end else begin
                done <= 0;
            end
        end
    end

    // Combinational block for state update and data capture
    always @(*) begin
        next_state = state;

        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    data_reg[23:16] = in;
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                data_reg[15:8] = in;
                next_state = BYTE2;
            end
            BYTE2: begin
                data_reg[7:0] = in;
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
