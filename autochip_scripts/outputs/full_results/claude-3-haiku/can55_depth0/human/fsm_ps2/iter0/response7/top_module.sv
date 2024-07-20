module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter WAIT_FOR_START = 2'b00;
parameter RECEIVE_BYTE1 = 2'b01;
parameter RECEIVE_BYTE2 = 2'b10;
parameter RECEIVE_BYTE3 = 2'b11;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        WAIT_FOR_START: begin
            if (in[3]) begin
                next_state = RECEIVE_BYTE1;
                done = 1'b0;
            end
            else begin
                next_state = WAIT_FOR_START;
                done = 1'b0;
            end
        end
        RECEIVE_BYTE1: begin
            next_state = RECEIVE_BYTE2;
            done = 1'b0;
        end
        RECEIVE_BYTE2: begin
            next_state = RECEIVE_BYTE3;
            done = 1'b0;
        end
        RECEIVE_BYTE3: begin
            next_state = WAIT_FOR_START;
            done = 1'b1;
        end
        default: begin
            next_state = WAIT_FOR_START;
            done = 1'b0;
        end
    endcase
end

endmodule
