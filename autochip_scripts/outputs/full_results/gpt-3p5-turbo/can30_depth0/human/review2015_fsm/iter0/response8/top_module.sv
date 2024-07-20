module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    // Define the states of the finite state machine
    typedef enum logic [2:0] {
        SEARCH,
        DETECT,
        SHIFT_ENA,
        COUNTING,
        DONE,
        WAIT_ACK
    } state_t;
    
    // Define the current state and next state variables
    reg state_t current_state;
    reg state_t next_state;
    
    // Set the initial state of the FSM
    always @(posedge clk) begin
        if (reset) begin
            current_state <= SEARCH;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Set the next state of the FSM based on the current state and input conditions
    always @(*) begin
        case (current_state)
            SEARCH: begin
                if (data == 4'b1101) begin
                    next_state = DETECT;
                end else begin
                    next_state = SEARCH;
                end
            end
            
            DETECT: begin
                next_state = SHIFT_ENA;
            end
            
            SHIFT_ENA: begin
                if (shift_ena && counting) begin
                    next_state = COUNTING;
                end else if (!shift_ena) begin
                    next_state = DETECT;
                end else begin
                    next_state = SHIFT_ENA;
                end
            end
            
            COUNTING: begin
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNTING;
                end
            end
            
            DONE: begin
                if (ack) begin
                    next_state = WAIT_ACK;
                end else begin
                    next_state = DONE;
                end
            end
            
            WAIT_ACK: begin
                if (reset) begin
                    next_state = SEARCH;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
        endcase
    end
    
    // Set the outputs based on the current state
    always @(*) begin
        case (current_state)
            SEARCH: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
            end
            
            DETECT: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
            end
            
            SHIFT_ENA: begin
                shift_ena = 1;
                counting = 0;
                done = 0;
            end
            
            COUNTING: begin
                shift_ena = 0;
                counting = 1;
                done = 0;
            end
            
            DONE: begin
                shift_ena = 0;
                counting = 0;
                done = 1;
            end
            
            WAIT_ACK: begin
                shift_ena = 0;
                counting = 0;
                done = 0;
            end
        endcase
    end
endmodule
