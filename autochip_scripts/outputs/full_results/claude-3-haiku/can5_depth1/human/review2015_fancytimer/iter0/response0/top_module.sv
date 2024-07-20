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

localparam IDLE = 2'b00;
localparam DETECTING = 2'b01;
localparam COUNTING = 2'b10;
localparam COMPLETE = 2'b11;

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
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECTING;
                    end
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECTING: begin
                if (data == 1'b1) begin
                    delay[3] <= data;
                end else begin
                    delay[2] <= data;
                    delay[1] <= data;
                    delay[0] <= data;
                    state <= COUNTING;
                    counting <= 1;
                    counter <= delay + 1;
                end
            end
            COUNTING: begin
                if (counter == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= COMPLETE;
                end else begin
                    counter <= counter - 1;
                end
            end
            COMPLETE: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? counter : 4'bxxxx;

endmodule
