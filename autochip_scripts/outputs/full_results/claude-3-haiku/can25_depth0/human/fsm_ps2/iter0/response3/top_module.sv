module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter IDLE = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, BYTE3 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            done = 0;
            if (in[3]) begin
                next_state = BYTE1;
            end
            else begin
                next_state = IDLE;
            end
        end
        BYTE1: begin
            done = 0;
            next_state = BYTE2;
        end
        BYTE2: begin
            done = 0;
            next_state = BYTE3;
        end
        BYTE3: begin
            done = 1;
            next_state = IDLE;
        end
        default: begin
            done = 0;
            next_state = IDLE;
        end
    endcase
end

endmodule
