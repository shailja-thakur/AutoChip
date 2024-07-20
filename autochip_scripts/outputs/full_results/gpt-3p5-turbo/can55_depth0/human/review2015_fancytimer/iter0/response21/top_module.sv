module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [1:0] state;
reg [3:0] delay;
reg [9:0] counter;

// State machine states
parameter START = 2'b00;
parameter WAIT_PATTERN = 2'b01;
parameter READ_PATTERN = 2'b10;
parameter COUNT = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= START;
        delay <= 0;
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            START: begin
                if (data == 4'b1101) begin
                    state <= WAIT_PATTERN;
                end else begin
                    state <= START;
                end
            end
            WAIT_PATTERN: begin
                state <= READ_PATTERN;
            end
            READ_PATTERN: begin
                delay <= {data[3:0]};
                state <= COUNT;
            end
            COUNT: begin
                if (counter < (delay + 1) * 1000) begin
                    counter <= counter + 1;
                    counting <= 1;
                end else begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= START;
                end else begin
                    state <= WAIT_ACK;
                end
            end
        endcase
    end
end

assign count = delay - counter/1000;

endmodule
