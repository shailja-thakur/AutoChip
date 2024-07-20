module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam WAIT_START = 0, RECEIVE_BYTE1 = 1, RECEIVE_BYTE2 = 2, RECEIVE_BYTE3 = 3;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WAIT_START: begin
            if (in[3]) begin
                next_state = RECEIVE_BYTE1;
            end
        end
        RECEIVE_BYTE1: begin
            out_bytes[23:16] = in;
            next_state = RECEIVE_BYTE2;
        end
        RECEIVE_BYTE2: begin
            out_bytes[15:8] = in;
            next_state = RECEIVE_BYTE3;
        end
        RECEIVE_BYTE3: begin
            out_bytes[7:0] = in;
            next_state = WAIT_START;
            done = 1;
        end
    endcase
end

endmodule
