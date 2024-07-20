module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack ); 

reg [3:0] delay;
reg [4:0] state;
reg [3:0] counter;
reg start_sequence_detected;
reg [3:0] remaining_time;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        delay <= 0;
        counting <= 0;
        done <= 0;
        counter <= 0;
        start_sequence_detected <= 0;
        remaining_time <= 0;
    end else begin
        case (state)
            0: begin // Searching for start sequence
                if (data == 4'b1101) begin
                    start_sequence_detected <= 1;
                    state <= 1;
                end
            end
            1: begin // Shifting in delay[3:0]
                start_sequence_detected <= 0;
                delay <= data;
                state <= 2;
            end
            2: begin // Counting
                if (counter == (delay + 1)*1000 - 1) begin
                    counting <= 0;
                    done <= 1;
                    state <= 3;
                end else begin
                    counting <= 1;
                    counter <= counter + 1;
                end
            end
            3: begin // Waiting for acknowledgement
                if (ack) begin
                    done <= 0;
                    state <= 0;
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        count <= 4'b0000;
    end else begin
        if (counting) begin
            count <= remaining_time;
            if (counter % 1000 == 0) begin
                remaining_time <= remaining_time - 1;
            end
        end else begin
            count <= 4'bZZZZ; // Don't care value when not counting
        end
    end
end

endmodule
