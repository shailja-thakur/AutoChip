module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [2:0] state;
reg [3:0] delay;
reg [17:0] counter;
reg start_detected; 

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;          // Initial state: searching for input sequence 1101
        counting <= 0;            // Not counting
        done <= 0;                // Not done
        counter <= 0;             // Reset counter to 0
        start_detected <= 0;      // Start not detected
    end
    else begin
        case (state)
            3'b000: begin         // State 0: Searching for input sequence 1101
                if (start_detected && !data) begin
                    start_detected <= 0;
                    state <= 3'b001;
                end
                else if (!start_detected && data) begin
                    start_detected <= 1;
                    state <= 3'b000;
                end
                else begin
                    state <= 3'b000;
                end
            end

            3'b001: begin         // State 1: Shifting in delay[3:0]
                delay <= {data, delay[3:1]};
                state <= 3'b010;
            end

            3'b010: begin         // State 2: Start counting
                counting <= 1;
                counter <= (delay + 1) * 1000 - 1;
                state <= 3'b011;
            end

            3'b011: begin         // State 3: Counting
                if (counter != 0) begin
                    counter <= counter - 1;
                    state <= 3'b011;
                end
                else begin
                    counting <= 0;
                    done <= 1;
                    state <= 3'b100;
                end
            end

            3'b100: begin         // State 4: Wait for ack and reset
                if (ack) begin
                    done <= 0;
                    state <= 3'b000;
                    counter <= 0;
                end
                else begin
                    state <= 3'b100;
                end
            end
        endcase
    end
end

assign count = counting ? {counter[17:4]} : 4'bxxxx;

endmodule
