module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    localparam A = 2'd0;
    localparam B = 2'd1;
    localparam C = 2'd2;
    
    reg [1:0] state, next_state;
    reg [1:0] w_counter;
    reg [1:0] cycle_counter;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_counter <= 0;
            cycle_counter <= 0;
            z <= 0;
        end else begin
            state <= next_state;

            if (state == B) begin
                // Increment cycle counter
                cycle_counter <= cycle_counter + 1;

                // Increment w counter
                if (w == 1) begin
                    w_counter <= w_counter + 1;
                end

                // Check the w counter and cycle counter for three cycles
                if (cycle_counter == 3) begin
                    z <= (w_counter == 2);
                    cycle_counter <= 0;
                    w_counter <= 0;
                end else begin
                    z <= 0;
                end
            end else begin
                // Reset cycle and w counters when not in state B
                cycle_counter <= 0;
                w_counter <= 0;
                z <= 0;
            end
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (s == 1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (cycle_counter == 3)
                    next_state = B; // Stay in B to keep checking in the next 3 cycle block
                else
                    next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end
endmodule
