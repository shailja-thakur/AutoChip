module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [3:0] state;

parameter IDLE = 0;
parameter DETECTING = 1;
parameter COUNTING = 2;
parameter TIMED_OUT = 3;

always @(posedge clk) begin
    if (reset) begin
        delay <= 0;
        state <= IDLE;
        counting <= 0;
        done <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (data == 4'b1101) begin
                    delay <= data;
                    state <= DETECTING;
                end
            end
            DETECTING: begin
                delay <= data;
                state <= COUNTING;
                counting <= 1;
            end
            COUNTING: begin
                if (count == (delay + 1)) begin
                    counting <= 0;
                    done <= 1;
                    state <= TIMED_OUT;
                end
            end
            TIMED_OUT: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
    end else if (counting) begin
        if (count == (delay + 1) * 1000 - 1) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end else begin
        count <= 0;
    end
end

endmodule
