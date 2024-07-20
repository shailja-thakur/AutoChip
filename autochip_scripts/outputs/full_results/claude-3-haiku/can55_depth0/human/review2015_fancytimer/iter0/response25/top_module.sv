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

localparam IDLE = 0,
          DETECT_START = 1,
          LOAD_DELAY = 2,
          COUNTING = 3,
          NOTIFY_DONE = 4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= LOAD_DELAY;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            LOAD_DELAY: begin
                if (counter < 4) begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end else begin
                    delay <= shift_reg[3:0];
                    state <= COUNTING;
                    counter <= 0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (counter < (delay + 1) * 250) begin
                    counter <= counter + 1;
                    count <= (delay + 1) - (counter / 250);
                end else begin
                    state <= NOTIFY_DONE;
                    counting <= 0;
                    done <= 1;
                    counter <= 0;
                end
            end
            NOTIFY_DONE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
