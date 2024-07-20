module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// State encoding
typedef enum reg [1:0] {
    A = 2'b00, 
    B = 2'b01, 
    C = 2'b10
} state_t;

// State and next state
state_t state, next_state;

// Counters for clock cycles and w occurrences
reg [1:0] w_count;
reg [1:0] cycle_count;

// State transition
always @(posedge clk) begin
    if (reset) begin
        state <= A;
        w_count <= 2'b00;
        cycle_count <= 2'b00;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == B || state == C) begin
            if (cycle_count == 2'b11) begin
                cycle_count <= 2'b00;
                w_count <= 2'b00;
                if (w_count == 2'b10) 
                    z <= 1'b1; 
                else 
                    z <= 1'b0;
            end 
            else begin
                cycle_count <= cycle_count + 1'b1;
                if (w == 1'b1) 
                    w_count <= w_count + 1'b1;
            end
        end
    end
end

// Next state logic
always @(*) begin
    if (reset) 
        next_state = A;
    else begin
        case (state)
            A: if (s) 
                    next_state = B; 
                else 
                    next_state = A;
            B: if (cycle_count == 2'b11) 
                    next_state = C;
                else 
                    next_state = B;
            C: next_state = B;
            default: next_state = A;
        endcase
    end
end

endmodule
