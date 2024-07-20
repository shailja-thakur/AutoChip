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

localparam WAIT_START = 2'b00;
localparam RECEIVE_DELAY = 2'b01;
localparam COUNTING = 2'b10;
localparam WAIT_ACK = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= RECEIVE_DELAY;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            RECEIVE_DELAY: begin
                if (counter < 4) begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end else begin
                    delay <= shift_reg;
                    state <= COUNTING;
                    counter <= 0;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (counter < (delay + 1) * 250) begin
                    counter <= counter + 1;
                end else begin
                    counter <= 0;
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay - (counter / 250);

endmodule
