module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [2:0] state;

// Define states
parameter INIT = 0;
parameter SEARCH = 1;
parameter SHIFT_IN = 2;
parameter COUNT = 3;
parameter DONE = 4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= INIT;
        counting <= 0;
        done <= 0;
        delay <= 0;
    end else begin
        case (state)
            INIT:
                if (data == 1'b1 && $rose(data)) begin
                    state <= SEARCH;
                end else begin
                    state <= INIT;
                end
            SEARCH:
                if (data == 1'b0 && $fell(data)) begin
                    state <= INIT;
                end else if (data == 1'b1 && $rose(data)) begin
                    state <= SHIFT_IN;
                end else begin
                    state <= SEARCH;
                end
            SHIFT_IN:
                if (data == 1'b0 && $fell(data)) begin
                    delay <= {data, delay[3:1]};
                    if (delay == 4'b1101) begin
                        state <= COUNT;
                    end else begin
                        state <= INIT;
                    end
                end else begin
                    state <= SHIFT_IN;
                end
            COUNT:
                if (counting && count != (delay + 1)) begin
                    state <= COUNT;
                end else if (counting && count == (delay + 1)) begin
                    state <= DONE;
                end else begin
                    state <= INIT;
                end
            DONE:
                if (~ack) begin
                    state <= DONE;
                end else begin
                    state <= INIT;
                end
        endcase
    end
end

always @(posedge clk) begin
    if (state == COUNT) begin
        if (count == 0) begin
            counting <= 1;
            count <= delay;
        end else begin
            count <= count - 1;
        end
    end else begin
        counting <= 0;
    end

    if (state == DONE && ack) begin
        done <= 1;
    end else begin
        done <= 0;
    end
end

endmodule
