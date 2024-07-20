module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State declarations
    localparam A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State, counter, and output registers
    reg [1:0] state, next_state;
    reg [1:0] w_count; // counter to count w = 1 over 3 cycles
    reg [1:0] cycle_count; // counter for cycles in state B

    // State transition with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycle_count <= 0;
        end else begin
            state <= next_state;
            if (state == B) begin
                cycle_count <= cycle_count + 1;
                if (w) w_count <= w_count + 1;
                if (cycle_count == 2) cycle_count <= 0;
            end else begin
                w_count <= 0;
                cycle_count <= 0;
            end
        end
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            A: begin
                z = 0;
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (cycle_count == 2) begin
                    z = (w_count == 2) ? 1 : 0;
                    next_state = B; // stay in B to continue checking
                end else begin
                    z = 0;
                    next_state = B;
                end
            end
            default: begin // default case to handle unexpected states
                next_state = A;
                z = 0;
            end
        endcase
    end

endmodule
