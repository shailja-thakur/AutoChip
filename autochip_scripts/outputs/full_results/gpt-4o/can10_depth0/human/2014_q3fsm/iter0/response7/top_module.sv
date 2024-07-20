module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;

            if (state == B || state == C) begin
                cycle_count <= cycle_count + 1;   // Increment the cycle count
                if (w) begin
                    w_count <= w_count + 1;   // Count the number of 1's in w
                end
            end

            if(cycle_count == 2'b11) begin
                if (w_count == 2'b10) begin
                    z <= 1;    // Set z to 1 if w was 1 exactly twice in 3 cycles
                end else begin
                    z <= 0;    // Otherwise set z to 0
                end
                cycle_count <= 2'b00;
                w_count <= 2'b00;
            end
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            
            B: begin
                if(cycle_count == 2'b11)
                    next_state = A;
                else
                    next_state = B;
            end
            
            default: next_state = A; 

        endcase
    end
endmodule
