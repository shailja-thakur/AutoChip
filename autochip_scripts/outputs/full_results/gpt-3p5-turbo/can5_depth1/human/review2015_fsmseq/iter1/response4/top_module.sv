module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [3:0] next_state; // Add next_state register to avoid race condition
    reg prev_data;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            prev_data <= data;
            state <= next_state; // Update state with next_state on posedge clk
        end
    end
    
    always @(*) begin
        next_state = state; // Initialize next_state with current state
        case (state)
            0: begin
                if (prev_data & !data)
                    next_state = 1;
            end
            1: begin
                if (prev_data & data)
                    next_state = 2;
                else
                    next_state = 0;
            end
            2: begin
                if (prev_data & data)
                    next_state = 3;
                else
                    next_state = 0;
            end
            3: begin
                if (prev_data & !data) begin
                    next_state = 1;
                    start_shifting = 1; // Use non-blocking assignment for start_shifting
                end
            end
            default: next_state = 0;
        endcase
    end
endmodule
