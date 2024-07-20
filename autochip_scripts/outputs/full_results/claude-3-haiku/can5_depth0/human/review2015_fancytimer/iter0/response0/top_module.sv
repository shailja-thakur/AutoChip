module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] counter;
reg [3:0] state;
reg [3:0] shift_reg;

localparam IDLE = 4'd0;
localparam DETECT_PATTERN = 4'd1;
localparam SHIFT_DELAY = 4'd2;
localparam COUNT_DOWN = 4'd3;
localparam WAIT_ACK = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 1'b0;
        counting <= 1'b0;
        shift_reg <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    state <= SHIFT_DELAY;
                    shift_reg <= 4'b0;
                end
                else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            SHIFT_DELAY: begin
                if (counter < 4) begin
                    delay[3-counter] <= data;
                    counter <= counter + 1;
                end
                else begin
                    state <= COUNT_DOWN;
                    counter <= 0;
                    counting <= 1'b1;
                end
            end
            COUNT_DOWN: begin
                if (counter < (delay + 1)) begin
                    counter <= counter + 1;
                end
                else begin
                    counter <= 0;
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule
