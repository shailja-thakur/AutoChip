module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] state, next_state;
reg [3:0] delay;
reg [9:0] counter;
reg [3:0] temp_count;

// State definitions
parameter IDLE = 4'd0;
parameter DETECT = 4'd1;
parameter CAPTURE = 4'd2;
parameter COUNT = 4'd3;
parameter DONE = 4'd4;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = DETECT;
            end else begin
                next_state = IDLE;
            end
        end
        DETECT: begin
            if (data == 1'b0) begin
                next_state = DETECT;
            end else if (data == 1'b1) begin
                next_state = CAPTURE;
            end else begin
                next_state = IDLE;
            end
        end
        CAPTURE: begin
            if (counter < 4) begin
                next_state = CAPTURE;
            end else begin
                next_state = COUNT;
            end
        end
        COUNT: begin
            if (counter == (delay + 1) * 1000 - 1) begin
                next_state = DONE;
            end else begin
                next_state = COUNT;
            end
        end
        DONE: begin
            if (ack) begin
                next_state = IDLE;
            end else begin
                next_state = DONE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    case (state)
        IDLE: begin
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0;
            counter <= 10'b0;
            temp_count <= 4'b0;
        end
        DETECT: begin
            if (data == 1'b1) begin
                counter <= counter + 1;
            end else begin
                counter <= 10'b0;
            end
        end
        CAPTURE: begin
            if (counter < 4) begin
                delay[3 - counter] <= data;
                counter <= counter + 1;
            end
        end
        COUNT: begin
            counting <= 1'b1;
            counter <= counter + 1;
            temp_count <= delay - (counter / 1000);
        end
        DONE: begin
            counting <= 1'b0;
            done <= 1'b1;
        end
        default: begin
            // Do nothing
        end
    endcase
end

assign count = (state == COUNT) ? temp_count : 4'bxxxx;

endmodule
