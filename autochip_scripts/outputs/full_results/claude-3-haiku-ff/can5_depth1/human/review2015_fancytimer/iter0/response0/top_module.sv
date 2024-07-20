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

parameter IDLE = 4'd0;
parameter START = 4'd1;
parameter LOAD_DELAY = 4'd2;
parameter COUNT = 4'd3;
parameter DONE = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                // Look for start sequence 1101
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= START;
                end
            end
            START: begin
                // Shift in 4-bit delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[3:0];
                    state <= LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                counting <= 1;
                state <= COUNT;
                counter <= 0;
            end
            COUNT: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 250) begin // (delay + 1) * 1000 / 4 cycles
                    counting <= 0;
                    state <= DONE;
                end
            end
            DONE: begin
                done <= 1;
                if (ack) begin
                    done <= 0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - (counter / 250) : 4'bxxxx; // (counter / 4) to get the remaining time

endmodule
