module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    reg [1:0] state, next_state;
    reg [23:0] message;

    always @(posedge clk) begin
        // Synchronous reset
        if (reset) begin
            state <= IDLE;
            message <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (done) begin
                out_bytes <= message;
            end else begin
                out_bytes <= 24'bx;
            end
        end
    end

    always @(*) begin
        // Default values
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                message[23:16] = in;
                next_state = BYTE2;
            end
            BYTE2: begin
                message[15:8] = in;
                next_state = BYTE3;
            end
            BYTE3: begin
                message[7:0] = in;
                done = 1'b1;
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
