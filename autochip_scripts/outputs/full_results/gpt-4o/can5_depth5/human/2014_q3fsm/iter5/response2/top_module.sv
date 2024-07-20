module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B1 = 2'b01,
        B2 = 2'b10,
        B3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] w_count;

    // State transition: Synchronous process
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            w_count <= 2'b00;
            z <= 0;
        end
        else begin
            current_state <= next_state;
            if (current_state == B1 || current_state == B2 || current_state == B3) begin
                if (w) w_count <= w_count + 1;
            end
            if (current_state == B3) begin
                z <= (w_count == 2'b10) ? 1 : 0;
                w_count <= 0; // Reset w_count after 3 cycles
            end
            else begin
                z <= 0; // Default value
            end
        end
    end

    // Next state logic: Combinational process
    always_comb begin
        next_state = current_state;
        case(current_state)
            A: begin
                if (s) next_state = B1;
            end
            B1: begin
                next_state = B2;
            end
            B2: begin
                next_state = B3;
            end
            B3: begin
                next_state = B1; // Start next 3-cycle phase
            end
            default: next_state = A;
        endcase
    end

endmodule
