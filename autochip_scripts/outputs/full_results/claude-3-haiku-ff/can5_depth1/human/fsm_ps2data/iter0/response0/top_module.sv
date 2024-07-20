module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

parameter IDLE = 2'b00, RECEIVE_FIRST = 2'b01, RECEIVE_SECOND = 2'b10, RECEIVE_THIRD = 2'b11;
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
            if (in[3]) begin
                next_state = RECEIVE_FIRST;
            end
            else begin
                next_state = IDLE;
            end
            done = 0;
            out_bytes = 0;
        end
        RECEIVE_FIRST: begin
            next_state = RECEIVE_SECOND;
            done = 0;
            out_bytes[23:16] = in;
        end
        RECEIVE_SECOND: begin
            next_state = RECEIVE_THIRD;
            done = 0;
            out_bytes[15:8] = in;
        end
        RECEIVE_THIRD: begin
            next_state = IDLE;
            done = 1;
            out_bytes[7:0] = in;
        end
        default: begin
            next_state = IDLE;
            done = 0;
            out_bytes = 0;
        end
    endcase
end

endmodule
