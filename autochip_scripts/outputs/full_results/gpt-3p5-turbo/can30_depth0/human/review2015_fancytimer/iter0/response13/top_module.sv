module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining;
    reg [3:0] state;
    reg [3:0] next_state;

    // State encoding
    parameter IDLE = 4'b0000;
    parameter DETECT = 4'b0001;
    parameter SHIFT = 4'b0010;
    parameter COUNT = 4'b0011;
    parameter DONE = 4'b0100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            delay <= 0;
            remaining <= 0;
        end
        else begin
            state <= next_state;
            counting <= (state == COUNT) ? 1'b1 : 1'b0;
            
            case (state)
                IDLE: begin
                    if (data == 1'b1 && $past(data) == 1'b1 && $past({data, $past(data)}) == 3'b110) begin
                        next_state <= DETECT;
                    end
                end
                
                DETECT: begin
                    delay <= data;
                    next_state <= SHIFT;
                end
                
                SHIFT: begin
                    delay <= {delay[2:0], data};
                    if (delay[0] == 1'b1) begin
                        remaining <= delay;
                        next_state <= COUNT;
                        done <= 0;
                    end
                    else begin
                        next_state <= DONE;
                    end
                end
                
                COUNT: begin
                    if (remaining == 0) begin
                        remaining <= delay;
                        done <= 1;
                        next_state <= DONE;
                    end
                    else begin
                        remaining <= remaining - 1;
                        next_state <= COUNT;
                    end
                end
                
                DONE: begin
                    if (ack == 1'b1) begin
                        next_state <= IDLE;
                    end
                end
            endcase
        end
    end
    
    assign count = (state == COUNT) ? remaining : 4'bxxxx;
   
endmodule
