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
reg [3:0] shift_reg;

localparam WAIT_START = 4'd0;
localparam SHIFT_DELAY = 4'd1;
localparam COUNT_DOWN = 4'd2;
localparam WAIT_ACK = 4'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 1'b0;
        done <= 1'b0;
        shift_reg <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
    end else begin
        case (state)
            WAIT_START: begin
                if (shift_reg == 4'b1101) begin
                    state <= SHIFT_DELAY;
                    shift_reg <= 4'b0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            SHIFT_DELAY: begin
                shift_reg <= {data, shift_reg[3:1]};
                if (shift_reg[0] == 1'b0) begin
                    delay <= shift_reg[3:0];
                    state <= COUNT_DOWN;
                    counting <= 1'b1;
                    counter <= delay;
                end
            end
            COUNT_DOWN: begin
                if (counter == 4'b0) begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= WAIT_ACK;
                end else begin
                    counter <= counter - 4'b1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT_DOWN) ? counter : 4'bxxxx;

endmodule
