module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [2:0] state;
reg [3:0] delay;
reg [3:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        delay <= 0;
        counting <= 0;
        done <= 0;
        counter <= 0;
    end else begin
        case (state)
            0: if (data == 1) state <= 1;
            1: if (data == 1) state <= 2;
               else if (data == 0) state <= 0;
            2: if (data == 0) state <= 3;
               else if (data == 1) state <= 0;
            3: if (data == 1) begin
                    state <= 4;
                    delay <= {data, delay[3:1]};
                end else state <= 0;
            4: if (counter < ((delay + 1) * 1000) - 1) begin
                    counting <= 1;
                    counter <= counter + 1;
                end else begin
                    counting <= 0;
                    done <= 1;
                end
        endcase
    end
end

assign count = delay - (counter / 1000);
assign ack = done;

endmodule
