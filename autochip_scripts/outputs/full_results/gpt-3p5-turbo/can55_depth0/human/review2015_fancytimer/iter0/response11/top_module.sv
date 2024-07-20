module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

// Internal signals
reg [3:0] delay;
reg [3:0] remaining_time;
reg [3:0] counter;
reg [3:0] start_sequence;
reg [3:0] shift_reg;
reg start_detected;
reg [15:0] count_duration;
reg [1:0] state;

// Constants
parameter IDLE      = 2'd0;
parameter SEARCHING = 2'd1;
parameter COUNTING  = 2'd2;

// Sequential always block
always @(posedge clk) begin
    if(reset) begin
        state <= IDLE;
        start_sequence <= 4'b1101;
        shift_reg <= 4'b0000;
        counter <= 4'b0000;
        remaining_time <= 4'b0000;
        count_duration <= 16'd0;
        counting <= 0;
        done <= 0;
    end else begin
        case(state)
            IDLE: begin
                if(data == start_sequence) begin
                    shift_reg <= {shift_reg[2:0], data};
                    state <= SEARCHING;
                    start_detected <= 1;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            
            SEARCHING: begin
                shift_reg <= {shift_reg[2:0], data};
                
                if(shift_reg == 4'b1101) begin
                    delay <= shift_reg;
                    start_detected <= 0;
                    state <= COUNTING;
                end
                
                if(start_detected) begin
                    start_detected <= 1;
                    state <= IDLE;
                end
            end
            
            COUNTING: begin
                if(counting) begin
                    if(count_duration < (delay + 1) * 1000 - 1) begin
                        counter <= counter + 1;
                        count_duration <= count_duration + 1;
                        remaining_time <= delay - counter;
                    end else begin
                        counting <= 0;
                        done <= 1;
                    end
                end else begin
                    if(ack) begin
                        state <= IDLE;
                        start_detected <= 1;
                    end
                end
            end
        endcase
    end
end

// Assign output signal values
assign count = counting ? remaining_time : 4'b0000;

endmodule
