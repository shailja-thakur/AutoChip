module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    reg [3:0] state;
    reg [2:0] count;
    reg [3:0] shift_data;
    
    parameter IDLE = 2'b00;
    parameter DETECT_SEQUENCE = 2'b01;
    parameter SHIFT_IN = 2'b10;
    parameter WAIT_COUNT = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= DETECT_SEQUENCE;
                    end else begin
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= IDLE;
                    end
                end
                
                DETECT_SEQUENCE: begin
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                    shift_data[0] <= data;
                    shift_data[1] <= shift_data[0];
                    shift_data[2] <= shift_data[1];
                    shift_data[3] <= shift_data[2];
                    if (count < 4) begin
                        count <= count + 1;
                    end else begin
                        count <= 0;
                        state <= WAIT_COUNT;
                    end
                end
                
                SHIFT_IN: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    state <= WAIT_COUNT;
                end
                
                WAIT_COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                    if (done_counting) begin
                        state <= IDLE;
                        done <= 1;
                    end else begin
                        state <= WAIT_COUNT;
                    end
                end
            endcase
        end
    end
endmodule
