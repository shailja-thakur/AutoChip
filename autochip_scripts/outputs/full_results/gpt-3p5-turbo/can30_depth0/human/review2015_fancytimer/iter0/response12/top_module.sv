module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [3:0] timer_count;
reg [3:0] remaining_time;
reg [3:0] state;
reg [1:0] shift_reg;
reg [3:0] shifted_data;
reg start_sequence_detected;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counting <= 0;
        done <= 0;
        delay <= 0;
        timer_count <= 0;
        remaining_time <= 0;
        state <= 0;
        shift_reg <= 0;
        shifted_data <= 0;
        start_sequence_detected <= 0;
    end
    else begin
        case(state)
            0: begin
                if (start_sequence_detected) begin
                    state <= 1;
                    counting <= 1;
                end
                else begin
                    if (data == 4'b1101)
                        start_sequence_detected <= 1;
                end
            end
                
            1: begin
                shifted_data <= shifted_data << 1;
                shifted_data[0] <= data;
                count <= remaining_time;
                
                if (shift_reg == 3) begin
                    shift_reg <= 0;
                    delay <= shifted_data;
                    state <= 2;
                end
                else begin
                    shift_reg <= shift_reg + 1;
                end
            end
                
            2: begin
                if (timer_count == (delay + 1) * 1000) begin
                    counting <= 0;
                    done <= 1;
                    state <= 3;
                end
                else begin
                    timer_count <= timer_count + 1;
                end
            end
                
            3: begin
                if (ack == 1) begin
                    done <= 0;
                    state <= 0;
                    start_sequence_detected <= 0;
                end
            end
        endcase
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        remaining_time <= 0;
    end
    else begin
        case(state)
            2: begin
                if (timer_count >= 0 && timer_count <= delay * 1000) begin
                    remaining_time <= delay - (timer_count / 1000);
                end
                else begin
                    remaining_time <= 0;
                end
            end
            default: begin
                remaining_time <= delay;
            end
        endcase
    end
end

endmodule
