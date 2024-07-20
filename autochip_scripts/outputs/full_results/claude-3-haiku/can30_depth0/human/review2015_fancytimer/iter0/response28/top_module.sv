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

localparam S_IDLE = 4'd0;
localparam S_DETECT = 4'd1;
localparam S_SHIFT = 4'd2;
localparam S_COUNT = 4'd3;
localparam S_DONE = 4'd4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end
    else begin
        case (state)
            S_IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= S_SHIFT;
                    shift_reg <= 0;
                end
                else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            S_SHIFT: begin
                if (counter == 4'd3) begin
                    delay <= shift_reg[3:0];
                    state <= S_COUNT;
                    counter <= 0;
                    counting <= 1;
                end
                else begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end
            end
            S_COUNT: begin
                if (counter == delay) begin
                    counter <= 0;
                    counting <= 0;
                    state <= S_DONE;
                    done <= 1;
                end
                else begin
                    counter <= counter + 1;
                end
            end
            S_DONE: begin
                if (ack) begin
                    state <= S_IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = counter;

endmodule
