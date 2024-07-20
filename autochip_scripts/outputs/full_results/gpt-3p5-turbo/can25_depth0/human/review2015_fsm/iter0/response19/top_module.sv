module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
); 

reg [2:0] state; 
reg [3:0] delay;

parameter IDLE = 3'b000;
parameter DETECT = 3'b001;
parameter COUNT = 3'b010;
parameter WAIT = 3'b011;
parameter TIMEOUT = 3'b100;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= IDLE;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case(state)
            IDLE: begin
                if(data == 4'b1101) begin
                    state <= DETECT;
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    delay <= 4'b0;
                end
            end
            
            DETECT: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                delay <= data;
                state <= COUNT;
            end
            
            COUNT: begin
                counting <= 1'b1;
                if(done_counting) begin
                    state <= WAIT;
                end
            end
            
            WAIT: begin
                counting <= 1'b0;
                if(ack) begin
                    state <= TIMEOUT;
                    done <= 1'b1;
                end
            end
            
            TIMEOUT: begin
                done <= 1'b0;
                state <= IDLE;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
