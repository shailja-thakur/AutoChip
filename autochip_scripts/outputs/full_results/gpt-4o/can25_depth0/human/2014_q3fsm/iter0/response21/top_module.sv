module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [1:0] {A = 2'b00, B = 2'b01, C = 2'b10} state_t;
    state_t current_state, next_state;

    reg [1:0] w_count;
    reg [1:0] cycle_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 0;
        end
        else begin
            current_state <= next_state;

            if (current_state == B) begin
                cycle_count <= cycle_count + 1;
                if (w)
                    w_count <= w_count + 1;

                if (cycle_count == 2) begin
                    if (w_count == 2)
                        z <= 1;
                    else
                        z <= 0;
                        
                    // Reset counters after evaluation
                    cycle_count <= 0;
                    w_count <= 0;
                end else
                    z <= 0; // Next clock cycle after counting reset z
            end
        end
    end

    always @(*) begin
        case (current_state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B; // Always stay in B once entered
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
