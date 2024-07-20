module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

typedef enum {BYTE1, BYTE2, BYTE3, DONE} state_t;
state_t state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= BYTE1;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
            done = 0;
        end
        BYTE2: begin
            next_state = BYTE3;
            done = 0;
        end
        BYTE3: begin
            next_state = DONE;
            done = 0;
        end
        DONE: begin
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
            done = 1;
        end
        default: begin
            next_state = BYTE1;
            done = 0;
        end
    endcase
end

endmodule
