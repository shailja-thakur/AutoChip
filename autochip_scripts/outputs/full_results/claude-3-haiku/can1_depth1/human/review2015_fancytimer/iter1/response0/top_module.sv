module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] state;
reg [3:0] delay;
reg [11:0] counter;
reg [3:0] shift_reg;

localparam IDLE = 4'd0;
localparam DETECT_START = 4'd1;
localparam SHIFT_DELAY = 4'd2;
localparam COUNTING = 4'd3;
localparam WAIT_ACK = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        counter <= 0;
        delay <= 0;
        shift_reg <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        state <= SHIFT_DELAY;
                        counter <= 0;
                    end
                end
            end
            SHIFT_DELAY: begin
                shift_reg <= {data, shift_reg[3:1]};
                counter <= counter + 1;
                if (counter[3:0] == 4'b0100) begin
                    delay <= shift_reg;
                    state <= COUNTING;
                    counter <= 0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                counter <= counter + 1;
                if (counter == {4'd0, delay, 2'b0}) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                    count <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    if (state == COUNTING) begin
        count = delay - counter[11:2];
    end else begin
        count = 0;
    end
end

endmodule
