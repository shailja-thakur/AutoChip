module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter STATE_WAIT_FIRST = 2'b00;
parameter STATE_WAIT_SECOND = 2'b01;
parameter STATE_WAIT_THIRD = 2'b11;

reg [1:0] current_state, next_state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_WAIT_FIRST;
        byte_count <= 2'b00;
        done <= 1'b0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            STATE_WAIT_FIRST: begin
                if (in[3]) begin
                    byte_count <= 2'b01;
                    next_state <= STATE_WAIT_SECOND;
                end
                else begin
                    byte_count <= 2'b00;
                    next_state <= STATE_WAIT_FIRST;
                end
                done <= 1'b0;
            end
            STATE_WAIT_SECOND: begin
                byte_count <= 2'b10;
                next_state <= STATE_WAIT_THIRD;
                done <= 1'b0;
            end
            STATE_WAIT_THIRD: begin
                byte_count <= 2'b11;
                next_state <= STATE_WAIT_FIRST;
                done <= 1'b1;
            end
            default: begin
                byte_count <= 2'b00;
                next_state <= STATE_WAIT_FIRST;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
