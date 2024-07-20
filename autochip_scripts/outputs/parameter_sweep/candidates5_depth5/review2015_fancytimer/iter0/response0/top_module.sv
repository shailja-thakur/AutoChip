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
    reg [3:0] timer;
    reg [9:0] counter;
    
    always @(posedge clk) begin
        if(reset) begin
            state <= 0;
            counting <= 0;
            done <= 0;
            counter <= 0;
            timer <= 0;
        end else begin
            case(state)
                0: begin // Searching for input sequence 1101
                    if(data == 4'b1101) begin
                        state <= 1;
                        count <= 0;
                    end
                end
                1: begin // Shifting in 4 bits to determine delay
                    timer <= {timer[2:0], data}; // Shift in new data
                    
                    if(count >= 1000) begin // Wait for 1000 cycles
                        state <= 2;
                        counting <= 1;
                        counter <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
                2: begin // Counting for (delay[3:0] + 1) * 1000 cycles
                    if(counter >= (delay + 1) * 1000) begin
                        state <= 3;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                3: begin // Wait for ack before resetting
                    if(ack) begin
                        state <= 0;
                        done <= 0;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if(state == 1) begin
            delay <= timer;
        end
    end

endmodule
