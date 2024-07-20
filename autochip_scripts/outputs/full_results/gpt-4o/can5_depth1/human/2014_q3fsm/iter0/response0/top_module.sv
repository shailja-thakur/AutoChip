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
        C = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycles;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycles <= 0;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = state;
        z = 0;
        case (state)
            A: begin
                if (s == 1) begin
                    next_state = B;
                    cycles = 0;
                    w_count = 0;
                end
            end
            B: begin
                if (cycles == 3) begin
                    if (w_count == 2) z = 1;
                    else z = 0;
                    cycles = 0;
                    w_count = 0;
                end else begin
                    if (w == 1) w_count = w_count + 1;
                    cycles = cycles + 1;
                end
            end
        endcase
    end
    
endmodule
