module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [1:0] {A=2'b00, B=2'b01, COUNT=2'b10, EVAL=2'b11} state_t;
    state_t state, next_state;
    reg [1:0] w_count;        // To count the number of times w is 1 in three clock cycles
    reg [1:0] cycle_count;    // To count the three clock cycles

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycle_count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            case (next_state)
                A: begin
                    z <= 0;
                    w_count <= 0;
                    cycle_count <= 0;
                end

                B, COUNT: begin
                    if (cycle_count < 3) begin
                        cycle_count <= cycle_count + 1;
                        if (w) begin
                            w_count <= w_count + 1;
                        end
                    end
                end

                EVAL: begin
                    z <= (w_count == 2) ? 1 : 0;
                    w_count <= 0;
                    cycle_count <= 0;
                end
            endcase
        end
    end

    always_comb begin
        case (state)
            A: begin
                if (s) 
                    next_state = B;
                else 
                    next_state = A;
            end

            B: begin
                next_state = COUNT;
            end

            COUNT: begin
                if (cycle_count == 3) 
                    next_state = EVAL;
                else 
                    next_state = COUNT;
            end

            EVAL: begin
                next_state = B;
            end

            default: next_state = A;
        endcase
    end
endmodule
