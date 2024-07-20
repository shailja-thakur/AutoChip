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

localparam [3:0] IDLE = 4'd0,
                 DETECT_START = 4'd1,
                 CAPTURE_DURATION = 4'd2,
                 COUNTING = 4'd3,
                 WAIT_ACK = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        counter <= 4'd0;
        delay <= 4'd0;
        shift_reg <= 4'd0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= CAPTURE_DURATION;
                    shift_reg <= 4'd0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            CAPTURE_DURATION: begin
                if (counter == 4'd3) begin
                    delay <= shift_reg;
                    state <= COUNTING;
                    counter <= 4'd0;
                    counting <= 1'b1;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 4'd1;
                end
            end
            COUNTING: begin
                if (counter == delay) begin
                    counter <= 4'd0;
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= WAIT_ACK;
                end else begin
                    counter <= counter + 4'd1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? delay - counter : 4'd0;

endmodule
