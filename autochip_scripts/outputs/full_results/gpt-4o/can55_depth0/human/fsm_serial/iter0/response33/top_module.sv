module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_count;
    
    parameter IDLE = 4'b0000;
    parameter START = 4'b0001;
    parameter DATA = 4'b0010;
    parameter STOP = 4'b0011;
    parameter ERR = 4'b0100;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            done <= 0;
        end
        else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    if (in == 0)
                        next_state <= START;
                end
                START: begin
                    if (in == 0) begin
                        next_state <= DATA;
                        bit_count <= 0;
                    end
                    else
                        next_state <= IDLE;
                end
                DATA: begin
                    if (bit_count < 7) begin
                        bit_count <= bit_count + 1;
                        next_state <= DATA;
                    end
                    else
                        next_state <= STOP;
                end
                STOP: begin
                    if (in == 1) begin
                        done <= 1;
                        next_state <= IDLE;
                    end
                    else begin
                        next_state <= ERR;
                    end
                end
                ERR: begin
                    if (in == 1) begin
                        next_state <= IDLE;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end
    
    always @(state) begin
        done = 0;
        if (state == STOP && in == 1) begin
            done = 1;
        end
    end

endmodule
