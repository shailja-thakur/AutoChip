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
    localparam [2:0] START = 0;
    localparam [2:0] SHIFT_ENA = 1;
    localparam [2:0] WAIT_COUNTING = 2;
    localparam [2:0] DONE = 3;
    
    // Declare state variable and initialize to START state
    reg [2:0] state = START;

    // Sequential logic
    always @(posedge clk) begin
        if (reset) begin
            state <= START; // Reset to START state
            shift_ena <= 0; // Reset shift_ena
            counting <= 0; // Reset counting
            done <= 0; // Reset done
        end else begin
            case (state)
                START: begin
                    // Check for start sequence (1101)
                    if (data == 4'b1101) begin
                        state <= SHIFT_ENA; // Move to SHIFT_ENA state
                        shift_ena <= 1; // Assert shift_ena for 4 clock cycles
                    end
                end
                SHIFT_ENA: begin
                    shift_ena <= 0; // Deassert shift_ena
                    state <= WAIT_COUNTING; // Move to WAIT_COUNTING state
                    counting <= 1; // Assert counting
                end
                WAIT_COUNTING: begin
                    if (done_counting) begin
                        state <= DONE; // Move to DONE state
                        counting <= 0; // Deassert counting
                        done <= 1; // Assert done
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= START; // Move back to START state after acknowledgement
                        done <= 0; // Deassert done
                    end
                end
            endcase
        end
    end

endmodule
