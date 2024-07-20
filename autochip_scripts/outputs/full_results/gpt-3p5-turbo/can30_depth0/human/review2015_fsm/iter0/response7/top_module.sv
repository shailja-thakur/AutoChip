module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state; // state register
    
    // Define states
    parameter START = 2'b00; // start state
    parameter SHIFT = 2'b01; // shift state
    parameter COUNT = 2'b10; // count state
    parameter DONE = 2'b11; // done state
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= START; // reset to start state
            shift_ena <= 0; // clear shift enable
            counting <= 0; // clear counting signal
            done <= 0; // clear done signal
        end
        else begin
            case(state)
                START: begin
                    if (data == 4'b1101) begin
                        state <= SHIFT; // transition to shift state
                        shift_ena <= 1; // assert shift enable
                    end
                    else begin
                        state <= START; // stay in start state
                        shift_ena <= 0; // clear shift enable
                    end
                end
                
                SHIFT: begin
                    state <= COUNT; // transition to count state
                    shift_ena <= 0; // clear shift enable
                end
                
                COUNT: begin
                    if (done_counting) begin
                        state <= DONE; // transition to done state
                        counting <= 1; // assert counting signal
                    end
                    else begin
                        state <= COUNT; // stay in count state
                        counting <= 0; // clear counting signal
                    end
                end
                
                DONE: begin
                    if (ack) begin
                        state <= START; // transition to start state
                        counting <= 0; // clear counting signal
                        done <= 0; // clear done signal
                    end
                    else begin
                        state <= DONE; // stay in done state
                    end
                end
            endcase
        end
    end
endmodule
