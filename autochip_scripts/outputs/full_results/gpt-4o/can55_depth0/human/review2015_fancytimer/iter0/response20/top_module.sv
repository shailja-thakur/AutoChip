module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] state;
    reg [3:0] delay;
    reg [15:0] counter;
    reg [3:0] shift_reg;
    
    localparam STATE_IDLE     = 4'd0,
               STATE_SHIFT    = 4'd1,
               STATE_WAIT     = 4'd2,
               STATE_DONE     = 4'd3;
    
    assign count = delay;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_IDLE;
            count <= 4'd0;
            delay <= 4'd0;
            counter <= 16'd0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_reg <= 4'd0;
        end else begin
            case (state)
                STATE_IDLE: begin
                    if (counter < 16'd4) begin
                        // Shifting in first 4 bits to detect 1101 pattern
                        shift_reg <= {shift_reg[2:0], data};
                        if (shift_reg == 4'b1101) begin
                            state <= STATE_SHIFT;
                            counter <= 16'd0;
                        end else begin
                            counter <= counter + 1;
                        end
                    end
                end
                STATE_SHIFT: begin
                    if (counter < 16'd4) begin
                        // Shifting in the delay[3:0] bits
                        delay <= {delay[2:0], data};
                        counter <= counter + 1;
                    end else begin
                        state <= STATE_WAIT;
                        counter <= (delay + 1) * 16'd1000;
                        counting <= 1'b1;
                    end
                end
                STATE_WAIT: begin
                    if (counter > 16'd0) begin
                        counter <= counter - 1;
                        delay <= (counter / 1000);
                    end else begin
                        counting <= 1'b0;
                        state <= STATE_DONE;
                        done <= 1'b1;
                    end
                end
                STATE_DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                        state <= STATE_IDLE;
                    end
                end
            endcase
        end
    end
    
endmodule
