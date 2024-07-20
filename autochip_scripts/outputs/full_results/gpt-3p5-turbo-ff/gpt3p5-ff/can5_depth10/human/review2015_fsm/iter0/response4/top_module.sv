module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states
    parameter IDLE = 2'b00;
    parameter SEARCH = 2'b01;
    parameter SHIFT = 2'b10;
    parameter COUNT = 2'b11;

    reg [1:0] state;
    reg [3:0] shift_counter;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 4'b0000;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data) begin
                        state <= SEARCH;
                    end
                end
                
                SEARCH: begin
                    if (data) begin
                        if (data == 4'b1101) begin
                            state <= SHIFT;
                            shift_counter <= 4'b0000;
                            shift_ena <= 1;
                        end
                    end else begin
                        state <= IDLE;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end
                
                SHIFT: begin
                    if (data) begin
                        shift_counter <= shift_counter + 1;
                        if (shift_counter == 4'b0100) begin
                            state <= COUNT;
                            shift_ena <= 0;
                            counting <= 1;
                        end
                    end else begin
                        state <= SEARCH;
                        shift_ena <= 0;
                    end
                end
                
                COUNT: begin
                    if (done_counting) begin
                        state <= IDLE;
                        counting <= 0;
                        done <= 1;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            shift_counter <= 4'b0000;
        end else begin
            if (state == COUNT && !done_counting) begin
                shift_counter <= 4'b0000;
            end
        end
    end
    
endmodule
