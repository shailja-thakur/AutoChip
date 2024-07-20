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

localparam WAIT_PATTERN = 2'b00;
localparam WAIT_DELAY   = 2'b01;
localparam COUNTING     = 2'b10;
localparam WAIT_ACK     = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        pattern <= 4'b0000;
        delay <= 4'b0000;
        counter <= 4'b0000;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_PATTERN: begin
                if (pattern == 4'b1101) begin
                    state <= WAIT_DELAY;
                    pattern <= 4'b0000;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            WAIT_DELAY: begin
                delay <= {delay[2:0], data};
                if (delay[3:0] == 4'b1111) begin
                    state <= COUNTING;
                    counter <= 4'b0000;
                    counting <= 1'b1;
                end
            end
            COUNTING: begin
                counter <= counter + 4'b0001;
                if (counter == delay + 4'b0001) begin
                    state <= WAIT_ACK;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_PATTERN;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = counter - 4'b0001;

endmodule
