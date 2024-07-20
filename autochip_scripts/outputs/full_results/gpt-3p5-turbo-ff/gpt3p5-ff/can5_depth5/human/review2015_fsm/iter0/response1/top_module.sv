module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    // Define the states
    reg [2:0] state;
    parameter IDLE = 3'b000;
    parameter DETECT_PATTERN = 3'b001;
    parameter SHIFT_IN = 3'b010;
    parameter WAIT_COUNTING = 3'b011;
    parameter TIMEOUT = 3'b100;
    
    // Define the next state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end else begin
                        state <= IDLE;
                    end
                end
                DETECT_PATTERN: begin
                    state <= SHIFT_IN;
                end
                SHIFT_IN: begin
                    if (shift_ena) begin
                        state <= WAIT_COUNTING;
                    end else begin
                        state <= SHIFT_IN;
                    end
                end
                WAIT_COUNTING: begin
                    if (done_counting) begin
                        state <= TIMEOUT;
                    end else begin
                        state <= WAIT_COUNTING;
                    end
                end
                TIMEOUT: begin
                    if (ack) begin
                        state <= IDLE;
                    end else begin
                        state <= TIMEOUT;
                    end
                end
            endcase
        end
    end
    
    // Define the state machine outputs
    always @(state) begin
        case (state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_PATTERN: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            SHIFT_IN: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            WAIT_COUNTING: begin
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            end
            TIMEOUT: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
        endcase
    end
    
endmodule
