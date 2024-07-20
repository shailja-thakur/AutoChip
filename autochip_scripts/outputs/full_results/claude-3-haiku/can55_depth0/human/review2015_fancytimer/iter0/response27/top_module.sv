module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_WAIT_START = 0;
localparam STATE_CAPTURE_DELAY = 1;
localparam STATE_COUNTING = 2;
localparam STATE_DONE = 3;

reg [1:0] state;
reg [3:0] delay;
reg [15:0] counter;

// Shift in the start pattern
always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
    end else begin
        case (state)
            STATE_WAIT_START: begin
                if (data == 1'b1) begin
                    if ({data, data, data, data} == 4'b1101) begin
                        state <= STATE_CAPTURE_DELAY;
                    end
                end
            end
            STATE_CAPTURE_DELAY: begin
                delay[3] <= data;
                delay[2] <= data;
                delay[1] <= data;
                delay[0] <= data;
                state <= STATE_COUNTING;
            end
            STATE_COUNTING: begin
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= STATE_DONE;
                end else begin
                    counter <= counter + 1;
                end
            end
            STATE_DONE: begin
                if (ack) begin
                    state <= STATE_WAIT_START;
                    counter <= 0;
                end
            end
        endcase
    end
end

// Output generation
assign count = (state == STATE_COUNTING) ? (delay - (counter / 1000)) : 4'bxxxx;
always @(*) begin
    case (state)
        STATE_WAIT_START: begin
            counting <= 1'b0;
            done <= 1'b0;
        end
        STATE_CAPTURE_DELAY: begin
            counting <= 1'b0;
            done <= 1'b0;
        end
        STATE_COUNTING: begin
            counting <= 1'b1;
            done <= 1'b0;
        end
        STATE_DONE: begin
            counting <= 1'b0;
            done <= 1'b1;
        end
    endcase
end

endmodule
