module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] IDLE = 2'b00, WAIT_FIRST = 2'b01, WAIT_SECOND = 2'b10, DONE = 2'b11;
reg [1:0] state, next_state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state <= WAIT_FIRST;
                    byte_count <= 1;
                end
                else begin
                    next_state <= IDLE;
                    byte_count <= 0;
                end
                done <= 0;
            end
            WAIT_FIRST: begin
                if (in[3]) begin
                    next_state <= WAIT_SECOND;
                    byte_count <= 2;
                end
                else begin
                    next_state <= IDLE;
                    byte_count <= 0;
                end
                done <= 0;
            end
            WAIT_SECOND: begin
                if (in[3]) begin
                    next_state <= DONE;
                    byte_count <= 3;
                end
                else begin
                    next_state <= IDLE;
                    byte_count <= 0;
                end
                done <= 0;
            end
            DONE: begin
                next_state <= IDLE;
                byte_count <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
