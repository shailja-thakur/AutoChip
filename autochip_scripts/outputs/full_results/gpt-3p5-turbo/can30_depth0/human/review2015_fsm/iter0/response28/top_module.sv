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
    reg [3:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or data or done_counting or ack) begin
        case(state)
            4'b0000: begin // Searching for start sequence 1101
                if (data == 4'b1101) begin
                    next_state = 4'b0001;
                end else begin
                    next_state = 4'b0000;
                end
            end
                
            4'b0001: begin // Asserting shift_ena for 4 clock cycles
                next_state = 4'b0010;
                shift_ena = 1;
            end
                
            4'b0010: begin // Waiting for counters to finish counting
                if (done_counting) begin
                    next_state = 4'b0011;
                    counting = 1;
                end else begin
                    next_state = 4'b0010;
                end
            end
                
            4'b0011: begin // Notifying user and waiting for ack
                if (ack) begin
                    next_state = 4'b0000;
                    done = 1;
                    shift_ena = 0;
                    counting = 0;
                end else begin
                    next_state = 4'b0011;
                end
            end
        endcase
    end

endmodule
