module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAITING = 2'b00;
localparam STATE_BYTE1 = 2'b01;
localparam STATE_BYTE2 = 2'b10;
localparam STATE_BYTE3 = 2'b11;

reg [1:0] state, next_state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAITING;
        byte_count <= 2'b00;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WAITING: begin
                if (in[3]) begin
                    next_state <= STATE_BYTE1;
                    byte_count <= 2'b01;
                end
                else begin
                    next_state <= STATE_WAITING;
                    byte_count <= 2'b00;
                end
                done <= 1'b0;
            end
            STATE_BYTE1: begin
                next_state <= STATE_BYTE2;
                byte_count <= 2'b10;
                done <= 1'b0;
            end
            STATE_BYTE2: begin
                next_state <= STATE_BYTE3;
                byte_count <= 2'b11;
                done <= 1'b0;
            end
            STATE_BYTE3: begin
                next_state <= STATE_WAITING;
                byte_count <= 2'b00;
                done <= 1'b1;
            end
            default: begin
                next_state <= STATE_WAITING;
                byte_count <= 2'b00;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
