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
    reg [3:0] shift_register;
    reg start;
    
    // State definitions
    localparam IDLE = 2'b00;
    localparam WAITING_START = 2'b01;
    localparam WAITING_DELAY = 2'b10;
    localparam COUNTING = 2'b11;
    
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0;
            counting <= 0;
            done <= 0;
            remaining_time <= 4'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1 && shift_register == 4'b1101) begin
                        state <= WAITING_DELAY;
                        counting <= 1;
                        start <= 1;
                        count <= delay;
                        remaining_time <= delay;
                    end else begin
                        state <= IDLE;
                        counting <= 0;
                        done <= 0;
                        start <= 0;
                    end
                end
                WAITING_START: begin
                    if (data == 1'b1 && shift_register == 4'b1101) begin
                        state <= WAITING_DELAY;
                        counting <= 1;
                        start <= 1;
                        count <= delay;
                        remaining_time <= delay;
                    end else begin
                        state <= IDLE;
                        counting <= 0;
                        done <= 0;
                        start <= 0;
                    end
                end
                WAITING_DELAY: begin
                    if (start) begin
                        delay <= shift_register;
                        state <= COUNTING;
                    end else begin
                        state <= WAITING_DELAY;
                    end
                end
                COUNTING: begin
                    if (remaining_time > 0) begin
                        remaining_time <= remaining_time - 1;
                        state <= COUNTING;
                    end else if (remaining_time == 0) begin
                        counting <= 0;
                        done <= 1;
                        state <= IDLE;
                    end else begin
                        state <= WAITING_START;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (start) begin
            shift_register <= {shift_register[2:0], data};
        end
    end
    
endmodule
