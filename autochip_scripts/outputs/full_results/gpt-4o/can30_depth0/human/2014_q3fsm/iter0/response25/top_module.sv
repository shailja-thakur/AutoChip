module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    reg [1:0] state, next_state;
    reg [1:0] w_count; // To count the number of 1's in last three clock cycles
    reg [1:0] cycle_counter; // To count three cycles

    // State definitions
    localparam A = 2'b00;
    localparam B = 2'b01;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_counter <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;

            if (state == B) begin
                // Count w if we are in state B
                if (cycle_counter < 2'b10) begin
                    cycle_counter <= cycle_counter + 1;
                    if (w) w_count <= w_count + 1;
                end else if (cycle_counter == 2'b10) begin
                    cycle_counter <= 2'b00;
                    if (w) w_count <= w_count + 1;

                    // Set z according to the w_count
                    if (w_count == 2'b10) z <= 1'b1;
                    else z <= 1'b0;

                    // Reset w_count for next three cycles period
                    w_count <= 2'b00;
                end
            end else begin
                z <= 1'b0;
                w_count <= 2'b00;
                cycle_counter <= 2'b00;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            
            B: begin
                if (cycle_counter == 2'b10)
                    next_state = B; // Stay in B to keep checking every three cycles
                else
                    next_state = B; // Continue in B
            end

            default: next_state = A;
        endcase
    end

endmodule
