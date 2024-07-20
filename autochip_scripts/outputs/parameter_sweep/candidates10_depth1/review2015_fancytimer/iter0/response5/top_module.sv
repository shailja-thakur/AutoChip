module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [15:0] timer;
    reg [4:0] state;

    // Start detecting pattern when not counting
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            counting <= 0;
            done <= 0;
            timer <= 0;
            delay <= 0;
        end else if (state == 0) begin
            if (data == 1'b1 && #1 $rose(data) && #1 $rose(data) && #1 $rose(data)) begin
                state <= 1;
            end
        end else if (state == 1) begin
            delay <= {data, delay[3:1]};
            state <= 2;
        end else if (state >= 2 && state <= 15) begin
            timer <= timer + 1;
            if (timer == (delay + 1) * 1000) begin
                state <= 16;
            end
        end else if (state == 16) begin
            done <= 1;
            if (ack) begin
                state <= 0;
                counting <= 0;
                done <= 0;
            end
        end
    end

    // Set counting output based on state
    always @(state or reset) begin
        counting <= (state >= 2 && state <= 15);
    end

    // Output count based on state
    always @(state or reset) begin
        if (state >= 2 && state <= 15) begin
            count <= delay;
        end else begin
            count <= 4'bxxxx;
        end
    end

endmodule
