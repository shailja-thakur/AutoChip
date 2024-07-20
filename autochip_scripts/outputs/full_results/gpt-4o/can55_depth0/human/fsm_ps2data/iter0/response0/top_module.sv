module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'd0,
        BYTE1 = 2'd1,
        BYTE2 = 2'd2,
        BYTE3 = 2'd3
    } state_t;

    state_t state, next_state;
    reg [23:0] message;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'b0;
            message <= 24'b0;
        end else begin
            state <= next_state;
            out_bytes <= message;
            done <= (state == BYTE3);
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 0;
                if (in[3]) begin
                    next_state = BYTE1;
                    message[23:16] = in;
                end
            end
            BYTE1: begin
                done = 0;
                next_state = BYTE2;
                message[15:8] = in;
            end
            BYTE2: begin
                done = 0;
                next_state = BYTE3;
                message[7:0] = in;
            end
            BYTE3: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end

endmodule
