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
    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            delay <= 4'b0000;
            counter <= 4'b0000;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            case (state)
                2'b00: begin // Waiting for start sequence
                    if (data == 4'b1101) begin
                        next_state = 2'b01;
                        counting <= 1;
                    end else begin
                        next_state = 2'b00;
                        counting <= 0;
                    end
                end
                2'b01: begin // Waiting for delay bits
                    delay <= data[3:0];
                    next_state = 2'b10;
                end
                2'b10: begin // Counting
                    counter <= delay;
                    if (counter == 4'b0000) begin
                        next_state = 2'b11;
                    end else begin
                        next_state = 2'b10;
                    end
                end
                2'b11: begin // Timer done
                    if (ack) begin
                        next_state = 2'b00;
                        done <= 0;
                    end else begin
                        next_state = 2'b11;
                        done <= 1;
                    end
                end
                default: begin
                    next_state = 2'b00;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'bxxxx;
        end else begin
            if (counting) begin
                count <= counter;
            end
        end
    end

endmodule
