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

localparam [1:0] IDLE = 2'b00, CAPTURING = 2'b01, COUNTING = 2'b10, DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                counting <= 0;
                done <= 0;
                if (data) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= CAPTURING;
                    end
                end
            end
            CAPTURING: begin
                pattern <= {pattern[2:0], data};
                if (pattern[3:0] == 4'b1110) begin
                    delay <= 4'b0;
                    state <= COUNTING;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (counter == (delay + 1) * 250 - 1) begin
                    counting <= 0;
                    done <= 1;
                    state <= DONE;
                end else begin
                    counter <= counter + 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign count = delay - (counter / 250);

endmodule
