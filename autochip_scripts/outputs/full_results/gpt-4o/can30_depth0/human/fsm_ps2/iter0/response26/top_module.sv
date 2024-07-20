module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum reg [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == BYTE3) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end

            BYTE1: begin
                next_state = BYTE2;
            end

            BYTE2: begin
                next_state = BYTE3;
            end
            
            BYTE3: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
