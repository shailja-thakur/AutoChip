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

// States
localparam SEARCH = 4'd0;
localparam SHIFT_DELAY = 4'd1;
localparam COUNT = 4'd2;
localparam WAIT_ACK = 4'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= SEARCH;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end
    else begin
        case (state)
            SEARCH: begin
                // Look for the start pattern 1101
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= SHIFT_DELAY;
                end
            end
            SHIFT_DELAY: begin
                // Shift in the delay value
                shift_reg <= {shift_reg[2:0], data};
                if (counter == 4'd3) begin
                    delay <= shift_reg;
                    state <= COUNT;
                    counting <= 1;
                    counter <= 0;
                end
                else begin
                    counter <= counter + 1;
                end
            end
            COUNT: begin
                // Count down the delay value
                counter <= counter + 1;
                if (counter == delay) begin
                    counter <= 0;
                    if (delay == 0) begin
                        state <= WAIT_ACK;
                        counting <= 0;
                        done <= 1;
                    end
                    else begin
                        delay <= delay - 1;
                    end
                end
            end
            WAIT_ACK: begin
                // Wait for user acknowledgement
                if (ack) begin
                    state <= SEARCH;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay : 4'bxxxx;

endmodule
