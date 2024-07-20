module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [3:0] state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [12:0] counter; // Counter for the 1000 cycles

    localparam WAIT_PATTERN = 4'b0000,
               READ_DELAY   = 4'b0001,
               COUNT_DOWN   = 4'b0010,
               NOTIFY       = 4'b0011;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_PATTERN;
            shift_reg <= 4'b0000;
            count <= 4'b0000;
            delay <= 4'b0000;
            counter <= 13'b0000000000000;
            counting <= 1'b0;
            done <= 1'b0;
        end 
        else begin
            case (state)
                WAIT_PATTERN: begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in the data
                    if (shift_reg == 4'b1101) begin
                        state <= READ_DELAY;
                    end
                end
                
                READ_DELAY: begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in the data
                    if (shift_reg == 4'b1) begin 
                        delay <= {shift_reg[2:0], data};
                        count <= {shift_reg[2:0], data};
                        state <= COUNT_DOWN;
                        counting <= 1'b1;
                        counter <= 13'b1111101000; // 1000 cycles
                    end
                end
                
                COUNT_DOWN: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                    end 
                    else begin
                        if (count > 0) begin
                            count <= count - 1;
                            counter <= 13'b1111101000; // Reload 1000 cycles
                        end 
                        else begin
                            counting <= 1'b0;
                            done <= 1'b1;
                            state <= NOTIFY;
                        end
                    end
                end
                
                NOTIFY: begin
                    if (ack) begin
                        done <= 1'b0;
                        state <= WAIT_PATTERN;
                    end
                end
                
                default: state <= WAIT_PATTERN;
            endcase
        end
    end
endmodule
