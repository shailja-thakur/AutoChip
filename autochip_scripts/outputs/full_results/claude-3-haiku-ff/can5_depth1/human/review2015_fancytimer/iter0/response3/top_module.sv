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
reg [3:0] pattern;
reg [1:0] state;

localparam IDLE = 2'b00, START = 2'b01, COUNTING = 2'b10, DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1 && pattern[3:0] == 4'b1101) begin
                    state <= START;
                    pattern <= 4'b0;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            START: begin
                if (pattern[3:0] == 4'b1101) begin
                    delay <= {data, pattern[3:1]};
                    state <= COUNTING;
                    counter <= delay;
                    counting <= 1'b1;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            COUNTING: begin
                if (counter == 4'b0000) begin
                    state <= DONE;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    counter <= counter - 1;
                end
            end
            DONE: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? counter : 4'bxxxx;

endmodule
