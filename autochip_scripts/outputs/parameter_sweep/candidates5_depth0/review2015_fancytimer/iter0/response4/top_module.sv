module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [2:0] state;
    reg [9:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'b0000;
            state <= 3'b000;
            counter <= 10'b0000000000;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                3'b000: begin // searching for input sequence 1101
                    if (data == 4'b1101) begin
                        delay <= data[3:0];
                        state <= 3'b001;
                    end
                end

                3'b001: begin // shifting in 4 bits to determine delay
                    delay <= {data, delay[3:1]};
                    state <= 3'b010;
                end

                3'b010: begin // start counting
                    counting <= 1;
                    state <= 3'b011;
                    counter <= (delay + 1) * 10'b100;
                end

                3'b011: begin // counting
                    if (counter == 10'b0000000000) begin
                        state <= 3'b100;
                        done <= 1;
                    end else begin
                        counter <= counter - 1;
                    end
                end

                3'b100: begin // wait for ack and reset
                    if (ack) begin
                        state <= 3'b000;
                        counting <= 0;
                        done <= 0;
                        delay <= 4'b0000;
                    end
                end
            endcase
        end
    end

    assign count = counting ? delay : 4'b0000;

endmodule
