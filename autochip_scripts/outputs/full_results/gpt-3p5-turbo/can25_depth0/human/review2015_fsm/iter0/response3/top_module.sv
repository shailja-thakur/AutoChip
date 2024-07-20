module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Defining the states of the finite-state machine
    parameter S_IDLE = 0;
    parameter S_DETECT = 1;
    parameter S_SHIFT = 2;
    parameter S_COUNTING = 3;
    parameter S_DONE = 4;
    
    reg [2:0] state; // Current state of the finite-state machine
    
    // Output registers
    reg shift_ena_reg;
    reg counting_reg;
    reg done_reg;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            shift_ena_reg <= 0;
            counting_reg <= 0;
            done_reg <= 0;
        end else begin
            case (state)
                S_IDLE: begin
                    if (data == 4'b1101) begin
                        state <= S_DETECT;
                        shift_ena_reg <= 1;
                    end else begin
                        state <= S_IDLE;
                        shift_ena_reg <= 0;
                    end
                end
                
                S_DETECT: begin
                    state <= S_SHIFT;
                    shift_ena_reg <= 1;
                end
                
                S_SHIFT: begin
                    state <= S_COUNTING;
                    shift_ena_reg <= 0;
                    counting_reg <= 1;
                end
                
                S_COUNTING: begin
                    if (done_counting) begin
                        state <= S_DONE;
                        counting_reg <= 0;
                        done_reg <= 1;
                    end else begin
                        state <= S_COUNTING;
                        counting_reg <= 1;
                    end
                end
                
                S_DONE: begin
                    if (ack) begin
                        state <= S_IDLE;
                        done_reg <= 0;
                    end else begin
                        state <= S_DONE;
                    end
                end
            endcase
        end
    end
    
    // Assigning output registers to output signals
    assign shift_ena = shift_ena_reg;
    assign counting = counting_reg;
    assign done = done_reg;
    
endmodule
