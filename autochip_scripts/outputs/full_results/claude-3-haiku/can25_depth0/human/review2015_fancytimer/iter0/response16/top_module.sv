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

localparam STATE_WAIT_START = 4'd0;
localparam STATE_CAPTURE_DELAY = 4'd1;
localparam STATE_COUNTING = 4'd2;
localparam STATE_DONE = 4'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        counting <= 1'b0;
        done <= 1'b0;
        counter <= 4'b0;
        delay <= 4'b0;
    end else begin
        case (state)
            STATE_WAIT_START: begin
                if (data == 1'b1 && counter == 4'd0) begin
                    counter <= 4'd1;
                end else if (data == 1'b1 && counter == 4'd1) begin
                    counter <= 4'd2;
                end else if (data == 1'b0 && counter == 4'd2) begin
                    counter <= 4'd3;
                end else if (data == 1'b1 && counter == 4'd3) begin
                    state <= STATE_CAPTURE_DELAY;
                    counter <= 4'd0;
                end else begin
                    counter <= 4'd0;
                end
            end

            STATE_CAPTURE_DELAY: begin
                delay[3] <= data;
                counter <= counter + 4'd1;
                if (counter == 4'd4) begin
                    state <= STATE_COUNTING;
                    counter <= 4'd0;
                    counting <= 1'b1;
                end
            end

            STATE_COUNTING: begin
                counter <= counter + 4'd1;
                if (counter == delay + 4'd1) begin
                    counter <= 4'd0;
                    if (delay == 4'b0) begin
                        state <= STATE_DONE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end else begin
                        delay <= delay - 4'd1;
                    end
                end
            end

            STATE_DONE: begin
                if (ack == 1'b1) begin
                    state <= STATE_WAIT_START;
                    done <= 1'b0;
                end
            end

            default: begin
                state <= STATE_WAIT_START;
            end
        endcase
    end
end

assign count = delay;

endmodule
