module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
    state_t state, next_state;

    reg [23:0] byte_store;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_bytes <= 24'b0;
            done <= 0;
            byte_store <= 24'b0;
        end else begin
            state <= next_state;
            if (done) begin
                out_bytes <= byte_store;
            end
        end
    end

    always @(*) begin
        next_state = state;
        done = 0;

        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end
            end

            BYTE1: begin
                byte_store[23:16] = in;
                next_state = BYTE2;
            end

            BYTE2: begin
                byte_store[15:8] = in;
                next_state = BYTE3;
            end

            BYTE3: begin
                byte_store[7:0] = in;
                next_state = IDLE;
                done = 1;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
