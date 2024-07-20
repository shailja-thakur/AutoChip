module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [1:0] {A, B} state_t;
    state_t state, next_state;
    logic [1:0] w_count;  // To count the number of times w is 1 in three clock cycles
    logic [1:0] cycle_count;  // To count the three clock cycles
    
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
            w_count <= 0;
            cycle_count <= 0;
        end
        else begin
            state <= next_state;
            
            case (state)
                A: begin
                    if (s) begin
                        next_state <= B;
                        z <= 0;
                        w_count <= 0;
                        cycle_count <= 0;
                    end
                    else begin
                        next_state <= A;
                        z <= 0;
                    end
                end
                B: begin
                    if (cycle_count == 2) begin
                        if (w == 1) 
                            w_count <= w_count + 1;

                        if (w_count == 2) 
                            z <= 1;
                        else 
                            z <= 0;

                        cycle_count <= 0;
                        w_count <= 0;
                    end
                    else begin
                        if (w == 1) 
                            w_count <= w_count + 1;

                        cycle_count <= cycle_count + 1;
                        z <= 0;
                    end
                    next_state <= B;
                end
                default: begin
                    next_state <= A;
                    z <= 0;
                end
            endcase
        end
    end
endmodule
