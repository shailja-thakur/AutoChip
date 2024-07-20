module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [3:0] count;

// State machine states
parameter S_IDLE = 2'b00;  // Idle state - waiting for start pattern
parameter S_COUNT = 2'b01;  // Counting state
parameter S_DONE = 2'b10;  // Done state - waiting for acknowledge

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= S_IDLE;
        counting <= 0;
        done <= 0;
        count <= 0;
        delay <= 0;
    end else begin
        case(state)
            S_IDLE: begin
                if(data == 4'b1101) begin
                    delay <= data[3:0];
                    state <= S_COUNT;
                    counting <= 1;
                end
            end

            S_COUNT: begin
                if(count == (delay + 1) * 1000) begin
                    state <= S_DONE;
                    counting <= 0;
                    count <= 0;
                end else begin
                    count <= count + 1;
                end
            end

            S_DONE: begin
                if(ack) begin
                    state <= S_IDLE;
                    done <= 0;
                end else begin
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
