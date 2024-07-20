module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum logic [2:0] {STATE_A = 3'b000, STATE_B = 3'b001, COUNT_1 = 3'b010, COUNT_2 = 3'b011, COUNT_3 = 3'b100} state_t;
    state_t current_state, next_state;
    reg [1:0] w_count;  // counter for 'w' = 1 in the last three clock cycles
    reg [1:0] cycle_count; // counter for three clock cycles

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            
            case (current_state)
                STATE_A: begin
                    z <= 1'b0;
                    if (s == 1) begin
                        next_state <= STATE_B;
                    end else begin
                        next_state <= STATE_A;
                    end
                end
                
                STATE_B: begin
                    z <= 1'b0;
                    w_count <= 2'b00;
                    cycle_count <= 2'b00;
                    next_state <= COUNT_1;
                end
                
                COUNT_1, COUNT_2: begin
                    if (w) begin
                        w_count <= w_count + 1;
                    end
                    
                    cycle_count <= cycle_count + 1;
                    
                    if (cycle_count == 2'b10) begin
                        next_state <= COUNT_3;
                    end else begin
                        next_state <= current_state == COUNT_1 ? COUNT_2 : COUNT_3;
                    end
                end
                
                COUNT_3: begin
                    if (w) begin
                        w_count <= w_count + 1;
                    end
                    
                    if (w_count == 2'd2) begin
                        z <= 1'b1;
                    end else begin
                        z <= 1'b0;
                    end
                    
                    cycle_count <= 2'b00;
                    w_count <= 2'b00;
                    next_state <= COUNT_1;
                end
                
                default: begin
                    next_state <= STATE_A;
                end
            endcase
        end
    end

endmodule
