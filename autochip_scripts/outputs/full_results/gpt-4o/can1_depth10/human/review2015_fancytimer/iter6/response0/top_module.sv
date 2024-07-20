module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// Declare internal variables
reg [3:0] pattern;
reg [3:0] delay;
reg [2:0] bit_count; // To count the number of bits shifted
reg [13:0] counter;

// State encoding
localparam IDLE       = 3'd0;
localparam PATTERN    = 3'd1;
localparam LOAD_DELAY = 3'd2;
localparam COUNT      = 3'd3;
localparam DONE       = 3'd4;

reg [2:0] state;

// Sequential logic to manage states and internal variables
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        count <= 4'd0;
        pattern <= 4'd0;
        delay <= 4'd0;
        counter <= 14'd0;
        bit_count <= 3'd0;
    end else begin
        case (state)
            IDLE: begin
                done <= 0;
                counting <= 0;
                counter <= 14'd0;
                if (pattern != 4'b1101) begin
                    pattern <= {pattern[2:0], data};
                end
                if (pattern == 4'b1101) begin
                    state <= LOAD_DELAY;
                    pattern <= 4'd0;
                    bit_count <= 3'd0; // Reset bit count for loading delay
                    delay <= 4'd0;
                end
            end

            LOAD_DELAY: begin
                if (bit_count < 4) begin
                    delay <= {delay[2:0], data};
                    bit_count <= bit_count + 1;
                end else begin
                    state <= COUNT;
                    counting <= 1;
                    counter <= (delay + 1) * 1000; // Initialize the counter
                    count <= delay;
                end
            end

            COUNT: begin
                if (counter > 0) begin
                    counter <= counter - 1;
                    if (counter % 1000 == 0 && counter != (delay + 1) * 1000) begin
                        if (count > 0) begin
                            count <= count - 1;
                        end
                    end
                end else begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end
            end

            DONE: begin
                if (ack) begin
                    state <= IDLE;
                    delay <= 4'd0;
                    pattern <= 4'd0;
                    counter <= 14'd0;
                    count <= 4'd0;
                end
            end

            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
