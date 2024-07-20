module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] temp_delay;
    reg [3:0] remaining_time;
    reg [3:0] current_state;
    
    reg [3:0] shift_reg;
    reg [3:0] shifted_data;
    
    reg [31:0] counter;
    
    parameter IDLE = 4'b0000;
    parameter START_DETECT = 4'b0001;
    parameter SHIFT_IN = 4'b0010;
    parameter COUNTING = 4'b0011;
    parameter TIMEOUT = 4'b0100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            temp_delay <= 0;
            remaining_time <= 0;
            current_state <= IDLE;
            counter <= 0;
            shift_reg <= 0;
            shifted_data <= 0;
        end else begin
            case (current_state)
                IDLE: begin
                    if (data == 1'b1 && shifted_data == 4'b1101) begin
                        current_state <= START_DETECT;
                    end else begin
                        current_state <= IDLE;
                    end
                end
                START_DETECT: begin
                    shift_reg <= {shift_reg[2:0], data};
                    shifted_data <= shift_reg;
                    if (shift_reg == 4'b1101) begin
                        current_state <= SHIFT_IN;
                    end else begin
                        current_state <= START_DETECT;
                    end
                end
                SHIFT_IN: begin
                    shift_reg <= {shift_reg[2:0], data};
                    shifted_data <= shift_reg;
                    temp_delay <= {shift_reg[2:0], data};
                    current_state <= COUNTING;
                    delay <= temp_delay;
                    remaining_time <= temp_delay;
                    counting <= 1;
                    counter <= 0;
                end
                COUNTING: begin
                    if (counter == (delay + 1) * 1000 - 1) begin
                        counter <= 0;
                        remaining_time <= remaining_time - 1;
                        if (remaining_time == 0) begin
                            current_state <= TIMEOUT;
                            counting <= 0;
                            done <= 1;
                        end else begin
                            current_state <= COUNTING;
                            counting <= 1;
                        end
                    end
                    else if (counter < (delay + 1) * 1000 - 1) begin
                        counter <= counter + 1;
                    end
                end
                TIMEOUT: begin
                    if (ack == 1) begin
                        current_state <= IDLE;
                        done <= 0;
                    end else begin
                        current_state <= TIMEOUT;
                        counting <= 0;
                    end
                end
            endcase
        end
    end

    assign count = remaining_time;

endmodule
