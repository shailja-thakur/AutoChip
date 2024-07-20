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

// State machine states
localparam IDLE = 4'd0;
localparam DETECT_START = 4'd1;
localparam CAPTURE_DELAY = 4'd2;
localparam COUNT_DOWN = 4'd3;
localparam NOTIFY = 4'd4;
localparam WAIT_ACK = 4'd5;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        shift_reg <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    state <= CAPTURE_DELAY;
                    shift_reg <= 4'b0;
                end
                else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end

            CAPTURE_DELAY: begin
                if (counter < 4'd4) begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end
                else begin
                    delay <= shift_reg;
                    state <= COUNT_DOWN;
                    counter <= 4'b0;
                    counting <= 1'b1;
                end
            end

            COUNT_DOWN: begin
                if (counter < (delay + 1) * 4'd1000) begin
                    counter <= counter + 1;
                    count <= (delay + 1) - (counter / 1000);
                end
                else begin
                    counting <= 1'b0;
                    state <= NOTIFY;
                end
            end

            NOTIFY: begin
                done <= 1'b1;
                state <= WAIT_ACK;
            end

            WAIT_ACK: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= IDLE;
                end
            end

            default: state <= IDLE;
        endcase
    end
end

endmodule
