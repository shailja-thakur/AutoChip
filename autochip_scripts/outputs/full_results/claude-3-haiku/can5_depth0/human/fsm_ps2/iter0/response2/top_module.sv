module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT = 2'b00;
localparam STATE_BYTE1 = 2'b01;
localparam STATE_BYTE2 = 2'b10;
localparam STATE_BYTE3 = 2'b11;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_WAIT: begin
            if (in[3]) begin
                next_state = STATE_BYTE1;
                done = 1'b0;
            end
            else begin
                next_state = STATE_WAIT;
                done = 1'b0;
            end
        end
        STATE_BYTE1: begin
            next_state = STATE_BYTE2;
            done = 1'b0;
        end
        STATE_BYTE2: begin
            next_state = STATE_BYTE3;
            done = 1'b0;
        end
        STATE_BYTE3: begin
            next_state = STATE_WAIT;
            done = 1'b1;
        end
        default: begin
            next_state = STATE_WAIT;
            done = 1'b0;
        end
    endcase
end

endmodule
