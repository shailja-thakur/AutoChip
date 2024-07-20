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

localparam IDLE = 4'b0000;
localparam DETECT = 4'b0001;
localparam SHIFT = 4'b0010;
localparam COUNT = 4'b0011;
localparam NOTIFY = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0000;
        delay <= 4'b0000;
        counter <= 4'b0000;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern[3:0] <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= SHIFT;
                    end else begin
                        state <= DETECT;
                    end
                end else begin
                    state <= IDLE;
                end
            end
            DETECT: begin
                if (data == 1'b1) begin
                    pattern[3:0] <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= SHIFT;
                    end else begin
                        state <= DETECT;
                    end
                end else begin
                    state <= IDLE;
                end
            end
            SHIFT: begin
                if (data == 1'b1) begin
                    delay[3:0] <= {delay[2:0], data};
                    if (counter == 4'b0011) begin
                        state <= COUNT;
                        counter <= 4'b0000;
                    end else begin
                        counter <= counter + 1'b1;
                        state <= SHIFT;
                    end
                end else begin
                    state <= IDLE;
                end
            end
            COUNT: begin
                counting <= 1'b1;
                if (counter == delay) begin
                    counter <= 4'b0000;
                    state <= NOTIFY;
                    counting <= 1'b0;
                end else begin
                    counter <= counter + 1'b1;
                end
            end
            NOTIFY: begin
                done <= 1'b1;
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - counter : 4'bxxxx;

endmodule
