module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] state;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Searching for start sequence 1101
                if (data == 1'b1 && {state[2:0], data} == 4'b1101) begin
                    state <= 1;
                end
            end
            1: begin // Shift in 4 bits for delay
                if (counter < 4) begin
                    delay[3 - counter] <= data;
                    counter <= counter + 1;
                end
                else begin
                    state <= 2;
                    counter <= 0;
                    counting <= 1;
                end
            end
            2: begin // Count down delay
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end
                else begin
                    state <= 3;
                    counter <= 0;
                    counting <= 0;
                    done <= 1;
                end
            end
            3: begin // Wait for acknowledgement
                if (ack) begin
                    state <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == 2) ? delay - (counter / 1000) : 4'bxxxx;

endmodule
