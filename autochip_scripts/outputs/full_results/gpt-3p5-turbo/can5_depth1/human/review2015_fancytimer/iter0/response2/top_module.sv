module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [3:0] shift_reg;
    reg start_sequence_detected;
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            counting <= 0;
            done <= 0;
            delay <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1) begin
                        start_sequence_detected <= 1;
                        state <= 1;
                    end
                end
                1: begin
                    if (data == 1) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data == 1) begin
                        state <= 2;
                    end else begin
                        state <= 3;
                        shift_reg[3:0] <= data;
                        delay <= shift_reg;
                    end
                end
                3: begin
                    if (remaining_time > 0) begin
                        counting <= 1;
                        remaining_time <= remaining_time - 1;
                        state <= 3;
                    end else if (remaining_time == 0) begin
                        counting <= 0;
                        done <= 1;
                        state <= 4;
                    end else begin
                        state <= 0;
                    end
                end
                4: begin
                    if (ack == 1) begin
                        counting <= 0;
                        done <= 0;
                        state <= 0;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else begin
            if (state == 3 && counting == 1) begin
                count <= remaining_time;
            end else begin
                count <= 0;
            end
        end
    end
    
endmodule
