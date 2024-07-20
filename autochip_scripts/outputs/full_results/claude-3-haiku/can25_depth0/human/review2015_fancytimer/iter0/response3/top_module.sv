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
reg [3:0] shift_reg;
reg [1:0] state;

localparam IDLE = 2'b00;
localparam DETECT_PATTERN = 2'b01;
localparam COUNT = 2'b10;
localparam NOTIFY = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_reg <= 0;
        counting <= 0;
        done <= 0;
        counter <= 0;
        delay <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    shift_reg <= 0;
                    state <= DETECT_PATTERN;
                end
                else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                if (counter < 4) begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end
                else begin
                    delay <= shift_reg[3:0];
                    counter <= 0;
                    state <= COUNT;
                    counting <= 1;
                end
            end
            COUNT: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end
                else begin
                    counter <= 0;
                    counting <= 0;
                    state <= NOTIFY;
                    done <= 1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay - (counter / 1000);

endmodule
