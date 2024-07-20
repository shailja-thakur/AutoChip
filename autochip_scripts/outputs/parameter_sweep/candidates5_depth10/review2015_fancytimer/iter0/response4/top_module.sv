module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [2:0] state;
    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [1:0] shift_reg;
    wire start;
    
    assign start = (shift_reg == 3'b110);
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 0;
            counting <= 0;
            done <= 0;
            count <= 0;
            delay <= 0;
            remaining_time <= 0;
            shift_reg <= 0;
        end else begin
            case(state)
                0: begin // Waiting for start pattern
                    if(data) begin
                        shift_reg <= {shift_reg[1:0], data};
                        if(start) begin
                            state <= 1;
                            count <= delay;
                            counting <= 1;
                        end
                    end
                end
                1: begin // Counting
                    remaining_time <= count;
                    if(count == 0) begin
                        counting <= 0;
                        done <= 1;
                        state <= 2;
                    end else begin
                        count <= count - 1;
                    end
                end
                2: begin // Waiting for ack
                    if(ack) begin
                        state <= 0;
                        counting <= 0;
                        done <= 0;
                        count <= 0;
                        delay <= 0;
                        remaining_time <= 0;
                        shift_reg <= 0;
                    end
                end
                default: state <= 0;
            endcase
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            delay <= 0;
        end else if(state == 0 && start) begin
            delay <= {shift_reg[3], shift_reg[2], shift_reg[1], shift_reg[0]};
        end
    end
  
endmodule
