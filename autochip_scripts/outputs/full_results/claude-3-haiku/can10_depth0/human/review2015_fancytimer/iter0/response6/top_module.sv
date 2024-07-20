module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam PATTERN_LENGTH = 4;
localparam DELAY_LENGTH = 4;

reg [PATTERN_LENGTH-1:0] pattern;
reg [DELAY_LENGTH-1:0] delay;
reg [PATTERN_LENGTH-1:0] pattern_register;
reg [DELAY_LENGTH-1:0] delay_register;
reg [11:0] counter;

// Pattern detection state machine
always @(posedge clk or posedge reset) begin
    if (reset) begin
        pattern <= 0;
    end else begin
        pattern <= {pattern[PATTERN_LENGTH-2:0], data};
        if (pattern == 4'b1101) begin
            pattern_register <= pattern;
            delay_register <= {data, data, data, data};
            counter <= 0;
            counting <= 1;
        end
    end
end

// Timer state machine
always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        if (counting) begin
            counter <= counter + 1;
            if (counter == (delay_register + 1) * 1000 - 1) begin
                counting <= 0;
                done <= 1;
            end
        end else if (done && ack) begin
            done <= 0;
        end
    end
end

assign count = counting ? delay_register - (counter / 1000) : 4'bXXXX;

endmodule
