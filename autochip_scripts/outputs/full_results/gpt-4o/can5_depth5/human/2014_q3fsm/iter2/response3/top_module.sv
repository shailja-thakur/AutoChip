module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;
    
    state_t state, next_state;

    reg [1:0] w_count; // To count number of times 'w' was high during three cycles
    reg [1:0] cycle_count; // To count three cycles

    // State transition: Synchronous process
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;

            // At each cycle, update w_count and cycle_count
            if (state != A) begin
                cycle_count <= cycle_count + 1'b1;
                if (w) w_count <= w_count + 1'b1;
                if (cycle_count == 2'b10) begin
                    if (w_count == 2'b10) 
                        z <= 1'b1;
                    else 
                        z <= 1'b0;
                    w_count <= 2'b00;
                    cycle_count <= 2'b00;
                end
                else begin
                    z <= 1'b0;
                end
            end
        end
    end

    // Next state logic: Combinational process
    always_comb begin
        next_state = state;
        case(state)
            A: begin
                if (s == 1'b1) next_state = B;
                else next_state = A;
            end
            B: begin
                if (cycle_count == 2'b10) next_state = B;
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end
endmodule
