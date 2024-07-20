module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

typedef enum reg [1:0] { BYTE1, BYTE2, BYTE3, DONE } state_t;
state_t state, next_state;

always @(posedge clk or negedge reset) begin
    if (~reset) begin
        state <= BYTE1;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @* begin
    case(state)
        BYTE1: begin
            done = 1'b0;
            if (in[2]) begin
                next_state = BYTE2;
            end
            else begin
                next_state = BYTE1;
            end
        end
        BYTE2: begin
            done = 1'b0;
            next_state = BYTE3;
        end
        BYTE3: begin
            done = 1'b0;
            next_state = DONE;
        end
        DONE: begin
            done = 1'b1;
            if (in[2]) begin
                next_state = BYTE2;
            end
            else begin
                next_state = BYTE1;
            end
        end
    endcase
end

endmodule
