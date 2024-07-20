module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [3:0] delay;
    reg [3:0] state;
    reg [2:0] counter;
    reg [9:0] clock_count;
    reg [1:0] ack_delay;
    reg start;
    reg [3:0] remaining_time;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            state <= 4'b0000;
            counter <= 3'b000;
            clock_count <= 10'b0000;
            counting <= 0;
            done <= 0;
            delay <= 0;
        end
        else
        begin
            case(state)
                4'b0000: // Start state
                    if (data == 1'b1)
                    begin
                        if (counter == 3'b111)
                        begin
                            if (start)
                            begin
                                state <= 4'b0001;
                                counting <= 1;
                                clock_count <= 10'b0000;
                                remaining_time <= delay;
                            end
                        end
                        else
                            counter <= counter + 1'b1;
                    end
                
                4'b0001: // Shift in delay bits
                    begin
                        if (clock_count == 10'b1111101001) // Wait 1000 cycles
                        begin
                            delay <= data;
                            state <= 4'b0010;
                        end
                        else
                            clock_count <= clock_count + 1'b1;
                    end
                
                4'b0010: // Counting state
                    begin
                        if (clock_count == ((delay + 1) * 10'd1000) - (10'd1 - ack_delay)) // Wait (delay + 1) * 1000 cycles
                        begin
                            state <= 4'b0011;
                            counting <= 0;
                        end
                        else
                            clock_count <= clock_count + 1'b1;
                    end
                
                4'b0011: // Done state
                    begin
                        if (~ack)
                            ack_delay <= 2'b00;
                        else if (ack && ~start)
                        begin
                            ack_delay <= ack_delay + 1'b1;
                            if (ack_delay == 2'b11)
                            begin
                                state <= 4'b0000;
                                done <= 1;
                            end
                        end
                        else
                            ack_delay <= 2'b00;
                    end
            endcase
        end
    end
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            count <= 4'b0000;
            start <= 1;
        end
        else
        begin
            case(state)
                4'b0000: // Start state
                    begin
                        count <= 4'bxxxx;
                        start <= 0;
                    end
                
                4'b0010: // Counting state
                    begin
                        if (clock_count >= ((delay + 1) * 10'd1000) - (10'd1 - ack_delay))
                            count <= remaining_time;
                        else if (clock_count >= (delay + 1) * 10'd1000 - 10'd1 - 10'd1000)
                            count <= remaining_time - 1;
                        else if (clock_count >= (delay + 1) * 10'd1000 - 10'd1 - 2 * 10'd1000)
                            count <= remaining_time - 2;
                        else if (clock_count >= (delay + 1) * 10'd1000 - 10'd1 - 3 * 10'd1000)
                            count <= remaining_time - 3;
                        else
                            count <= remaining_time;
                    end
                
                default:
                    count <= 4'bxxxx;
            endcase
        end
    end

endmodule
