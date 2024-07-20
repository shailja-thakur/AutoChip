module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam WAIT_FOR_START = 0;
localparam READ_DELAY = 1;
localparam COUNT_DOWN = 2;
localparam WAIT_FOR_ACK = 3;

reg [1:0] state;
reg [3:0] delay;
reg [9:0] counter;
reg [3:0] current_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
        current_count <= 0;
    end else begin
        case (state)
            WAIT_FOR_START: begin
                if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                    state <= READ_DELAY;
                    delay <= 0;
                end
            end
            READ_DELAY: begin
                if (counter < 4) begin
                    delay <= {delay[2:0], data};
                    counter <= counter + 1;
                end else begin
                    state <= COUNT_DOWN;
                    counter <= 0;
                    current_count <= delay + 1;
                    counting <= 1;
                end
            end
            COUNT_DOWN: begin
                if (counter < (current_count * 1000 - 1)) begin
                    counter <= counter + 1;
                end else begin
                    counter <= 0;
                    current_count <= current_count - 1;
                    if (current_count == 0) begin
                        state <= WAIT_FOR_ACK;
                        done <= 1;
                        counting <= 0;
                    end
                end
            end
            WAIT_FOR_ACK: begin
                if (ack == 1'b1) begin
                    state <= WAIT_FOR_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = current_count;

endmodule
