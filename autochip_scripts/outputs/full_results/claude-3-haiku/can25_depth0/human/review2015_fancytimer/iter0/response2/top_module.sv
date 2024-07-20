module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 3'b000;
localparam START = 3'b001;
localparam SHIFT_DELAY = 3'b010;
localparam COUNT = 3'b011;
localparam DONE = 3'b100;

reg [2:0] state;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1 && counter[3:0] == 4'b1101) begin
                    state <= START;
                    counter <= 0;
                end else begin
                    counter <= {counter[8:0], data};
                end
            end
            START: begin
                state <= SHIFT_DELAY;
                counter <= 0;
            end
            SHIFT_DELAY: begin
                if (counter[3:0] == 4'b0000) begin
                    delay <= data ? {delay[2:0], data} : delay;
                    state <= COUNT;
                    counter <= 0;
                    counting <= 1;
                end else begin
                    counter <= counter + 1;
                end
            end
            COUNT: begin
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= DONE;
                    counting <= 0;
                    counter <= 0;
                    done <= 1;
                end else begin
                    counter <= counter + 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

assign count = delay - (counter / 1000);

endmodule
