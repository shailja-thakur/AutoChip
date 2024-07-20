module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] counter;
    reg [2:0] state;
    wire detect_pattern;

    assign detect_pattern = (data == 4'b1101);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            state <= 3'b000;
            counter <= 0;
            delay <= 0;
        end else begin
            case (state)
                3'b000: begin // Waiting for start pattern
                    if (detect_pattern) begin
                        delay <= data[3:0];
                        state <= 3'b001;
                    end
                end
                3'b001: begin // Shifting in 4 bits
                    counter <= counter + 1;
                    if (counter == 3) begin
                        state <= 3'b010;
                        counting <= 1;
                    end
                end
                3'b010: begin // Counting
                    count <= delay;
                    if (counter == ((delay + 1) * 1000 - 1)) begin
                        state <= 3'b011;
                        counting <= 0;
                    end
                end
                3'b011: begin // Timeout
                    done <= 1;
                    if (ack) begin
                        state <= 3'b000;
                    end
                end
            endcase
        end
    end
endmodule
