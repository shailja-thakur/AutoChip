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
reg [3:0] pattern;

localparam [3:0] WAIT_PATTERN = 4'b0000;
localparam [3:0] CAPTURE_DELAY = 4'b0001;
localparam [3:0] COUNTING = 4'b0010;
localparam [3:0] DONE = 4'b0011;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        pattern <= 4'b1101;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            WAIT_PATTERN: begin
                if (data == pattern[0]) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= CAPTURE_DELAY;
                    end
                end else begin
                    pattern <= 4'b1101;
                end
            end
            CAPTURE_DELAY: begin
                if (counter < 4) begin
                    delay[3-counter] <= data;
                    counter <= counter + 1;
                end else begin
                    state <= COUNTING;
                    counter <= 0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                    count <= (delay + 1) * 1000 - counter - 1;
                end else begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= WAIT_PATTERN;
                    pattern <= 4'b1101;
                    done <= 0;
                end
            end
            default: state <= WAIT_PATTERN;
        endcase
    end
end

endmodule
