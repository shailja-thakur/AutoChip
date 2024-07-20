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

    // state definitions
    parameter IDLE = 0;
    parameter SEARCH = 1;
    parameter COUNT = 2;
    parameter DONE = 3;
    
    // internal state variable
    reg [1:0] state;

    // shift register for input pattern detection
    reg [3:0] shift_reg;
    reg [3:0] next_shift_reg;
    
    // start sequence constant
    parameter START_SEQ = 4'b1101;
    
    // initialization
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 0;
        end else begin
            state <= next_state;
            shift_reg <= next_shift_reg;
        end
    end
    
    // next state logic and output logic
    always @* begin
        next_shift_reg = {shift_reg[2:0], data};
        
        case (state)
            IDLE: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
                if (shift_reg == START_SEQ) begin
                    next_state = COUNT;
                end else begin
                    next_state = IDLE;
                end
            end
            SEARCH: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
                if (shift_reg[2:0] == START_SEQ[2:0] && shift_reg[3] == 0) begin
                    next_state = COUNT;
                end else begin
                    next_state = SEARCH;
                end
            end
            COUNT: begin
                shift_ena = 1;
                counting = 1;
                done = 0;
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNT;
                end
            end
            DONE: begin
                shift_ena = 0;
                counting = 0;
                done = 1;
                if (ack) begin
                    next_state = SEARCH;
                end else begin
                    next_state = DONE;
                end
            end
        endcase
    end
    
endmodule
