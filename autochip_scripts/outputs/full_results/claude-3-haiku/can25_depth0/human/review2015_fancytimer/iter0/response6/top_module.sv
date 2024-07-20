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

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        counting <= 0;
        done <= 0;
        counter <= 0;
        delay <= 0;
        shift_reg <= 0;
    end
    else begin
        case (state)
            0: begin // Waiting for 1101 pattern
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= 1;
                    shift_reg <= 0;
                end
                else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            1: begin // Shifting in delay value
                if (counter < 4) begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end
                else begin
                    delay <= shift_reg;
                    counter <= 0;
                    state <= 2;
                    counting <= 1;
                end
            end
            2: begin // Counting down
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end
                else begin
                    counter <= 0;
                    counting <= 0;
                    done <= 1;
                    state <= 3;
                end
            end
            3: begin // Waiting for acknowledge
                if (ack) begin
                    state <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == 2) ? delay - (counter / 1000) : 0;

endmodule
