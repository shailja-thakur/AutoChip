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
reg [3:0] shift_reg;
reg [1:0] state;

localparam SEARCH = 2'b00;
localparam CAPTURE = 2'b01;
localparam TIMER = 2'b10;
localparam DONE = 2'b11;

always @(posedge clk) begin
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
                // Shift in data until 1101 pattern is detected
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= CAPTURE;
                end
            end
            CAPTURE: begin
                // Shift in 4 bits to determine delay
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] != 4'b0000) begin
                    delay <= shift_reg[3:0];
                    state <= TIMER;
                    counting <= 1;
                    counter <= 0;
                end
            end
            TIMER: begin
                // Count down delay
                counter <= counter + 1;
                if (counter == delay) begin
                    counting <= 0;
                    state <= DONE;
                    done <= 1;
                end
            end
            DONE: begin
                // Wait for ack
                if (ack) begin
                    state <= SEARCH;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = counting ? delay - counter : 4'bxxxx;

endmodule
