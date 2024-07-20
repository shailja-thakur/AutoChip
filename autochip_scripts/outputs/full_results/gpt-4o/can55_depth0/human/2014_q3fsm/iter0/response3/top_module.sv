module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'd0,
        B = 2'd1,
        C1 = 2'd2,
        C2 = 2'd3
    } state_t;
    
    state_t state, next_state;
    
    // Counters for w = 1 instances
    reg [1:0] count;
    reg [1:0] cycle_count;
    
    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            count <= 2'd0;
            cycle_count <= 2'd0;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            A: begin
                if (s == 1'b1)
                    next_state = B;
            end
            B: begin
                if (cycle_count == 2'd2) begin
                    if (count == 2'd1)
                        next_state = C1;
                    else
                        next_state = C2;
                end
            end
            C1: begin
                if (cycle_count == 2'd2)
                    next_state = B;
            end
            C2: begin
                if (cycle_count == 2'd2)
                    next_state = B;
            end
        endcase
    end

    // Output and data path logic
    always @(posedge clk) begin
        if (reset) begin
            z <= 1'b0;
            count <= 2'd0;
            cycle_count <= 2'd0;
        end else begin
            case (state)
                A: begin
                    count <= 2'd0;
                    cycle_count <= 2'd0;
                    z <= 1'b0;
                end
                B: begin
                    cycle_count <= cycle_count + 1;
                    if (w == 1'b1) begin
                        count <= count + 1;
                    end
                end
                C1: begin
                    z <= 1'b1;
                    cycle_count <= 2'd0;
                    count <= 2'd0;
                end
                C2: begin
                    z <= 1'b0;
                    cycle_count <= 2'd0;
                    count <= 2'd0;
                end
            endcase
        end
    end
    
endmodule
