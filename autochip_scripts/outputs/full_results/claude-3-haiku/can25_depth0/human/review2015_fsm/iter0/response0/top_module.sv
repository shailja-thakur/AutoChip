module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

localparam [2:0] START = 3'b000,
                 SHIFT = 3'b001,
                 COUNT = 3'b010,
                 NOTIFY = 3'b011,
                 WAIT_ACK = 3'b100;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= START;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            START: begin
                if (data == 1'b1 && shift_count == 4'b1101) begin
                    next_state <= SHIFT;
                    shift_count <= 0;
                end
                else begin
                    shift_count <= {shift_count[2:0], data};
                end
            end
            SHIFT: begin
                shift_ena <= 1;
                if (shift_count == 4'b0100) begin
                    shift_ena <= 0;
                    next_state <= COUNT;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            COUNT: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY;
                end
            end
            NOTIFY: begin
                done <= 1;
                next_state <= WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack) begin
                    done <= 0;
                    next_state <= START;
                end
            end
        endcase
    end
end

endmodule
