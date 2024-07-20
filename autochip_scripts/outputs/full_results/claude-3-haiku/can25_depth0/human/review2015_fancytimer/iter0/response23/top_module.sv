module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay_count;
reg [3:0] delay;
reg [3:0] shift_reg;
reg [1:0] state;

localparam IDLE = 2'b00;
localparam SHIFT_PATTERN = 2'b01;
localparam COUNT = 2'b10;
localparam DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        delay_count <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= SHIFT_PATTERN;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            SHIFT_PATTERN: begin
                if (delay_count == 4'b0100) begin
                    delay <= shift_reg;
                    state <= COUNT;
                    delay_count <= 0;
                    counting <= 1;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                    delay_count <= delay_count + 1;
                end
            end
            COUNT: begin
                if (count == 0) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    count <= count - 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

counter counter_inst (
    .clk(clk),
    .reset(reset),
    .count(count),
    .delay(delay)
);

endmodule
module counter(
    input wire clk,
    input wire reset,
    output wire [3:0] count,
    input wire [3:0] delay
);

reg [13:0] counter;

always @(posedge clk) begin
    if (reset) begin
        counter <= 0;
    end else begin
        if (counter == ((delay + 1) * 14'd1000 - 1)) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
end

assign count = counter / 14'd1000;

endmodule
