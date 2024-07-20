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
localparam DETECT = 2'b01;
localparam COUNT = 2'b10;
localparam DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                counting <= 0;
                done <= 0;
                if (shift_reg == 4'b1101) begin
                    state <= DETECT;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            DETECT: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b0000) begin
                    state <= COUNT;
                    delay <= shift_reg[7:4];
                    counter <= delay + 1;
                    counting <= 1;
                end
            end
            COUNT: begin
                if (counter == 0) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter - 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign count = counting ? counter - 1 : 4'bxxxx;

endmodule
