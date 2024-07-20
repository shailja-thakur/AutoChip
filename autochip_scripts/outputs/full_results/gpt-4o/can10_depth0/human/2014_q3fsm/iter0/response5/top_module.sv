module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State declaration
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] counter; // To count the number of times w = 1 in three cycles
    reg [1:0] cycle_counter; // To count cycles within the B state

    // State register (sequential logic)
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            counter <= 2'b00;
            cycle_counter <= 2'b00;
            z <= 1'b0;
        end
        else begin
            current_state <= next_state;
            if (current_state == B) begin
                if (cycle_counter == 2'b11) begin
                    cycle_counter <= 2'b00;
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end
        end
    end

    // Next-state logic (combinational logic)
    always_comb begin
        next_state = current_state;
        case (current_state)
            A: begin
                if (s == 1'b1) begin
                    next_state = B;
                end
            end
            B: begin
                if (cycle_counter == 2'b11) begin
                    if (counter == 2'b10) begin
                        z = 1'b1;
                    end else begin
                        z = 1'b0;
                    end
                    counter = 2'b00; // Reset counter for next three cycles
                end
                if (w == 1'b1) begin
                    counter = counter + 1;
                end
            end
            default: next_state = A;
        endcase
    end

endmodule
