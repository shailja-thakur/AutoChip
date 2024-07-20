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

localparam WAITING = 2'b00;
localparam DETECTING = 2'b01;
localparam COUNTING = 2'b10;
localparam NOTIFYING = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAITING;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            WAITING: begin
                if (data == 1'b1 && pattern[3:0] == 4'b1101) begin
                    state <= DETECTING;
                    pattern <= 0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECTING: begin
                if (counter < 4) begin
                    delay[3-counter] <= data;
                    counter <= counter + 1;
                end else begin
                    counter <= 0;
                    state <= COUNTING;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                    count <= (delay + 1) - (counter / 1000);
                end else begin
                    counting <= 0;
                    state <= NOTIFYING;
                    done <= 1;
                end
            end
            NOTIFYING: begin
                if (ack) begin
                    state <= WAITING;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
