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

localparam WAIT_START = 3'b000;
localparam SHIFT_DURATION = 3'b001;
localparam COUNT = 3'b010;
localparam NOTIFY = 3'b011;
localparam WAIT_ACK = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        bit_count <= 0;
        pattern <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1;
                    bit_count <= 0;
                end else begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            end
            SHIFT_DURATION: begin
                bit_count <= bit_count + 1;
                if (bit_count == 4'b0011) begin
                    state <= COUNT;
                    shift_ena <= 0;
                    counting <= 1;
                end else begin
                    shift_ena <= 1;
                end
            end
            COUNT: begin
                if (done_counting) begin
                    state <= NOTIFY;
                    counting <= 0;
                    done <= 1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
            default: begin
                state <= WAIT_START;
            end
        endcase
    end
end

endmodule
