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

localparam IDLE = 4'd0;
localparam DETECT_PATTERN = 4'd1;
localparam CAPTURE_DELAY = 4'd2;
localparam COUNT = 4'd3;
localparam COMPLETE = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        shift_reg <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    state <= DETECT_PATTERN;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                state <= CAPTURE_DELAY;
            end
            CAPTURE_DELAY: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b0000) begin
                    delay <= 4'b0000;
                end else begin
                    delay <= shift_reg[3:0];
                end
                state <= COUNT;
                counting <= 1'b1;
            end
            COUNT: begin
                counter <= counter + 1;
                if (counter == delay) begin
                    counter <= 4'b0000;
                    if (delay == 4'b0000) begin
                        state <= COMPLETE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end else begin
                        delay <= delay - 1;
                    end
                end
            end
            COMPLETE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay : 4'bxxxx;

endmodule
