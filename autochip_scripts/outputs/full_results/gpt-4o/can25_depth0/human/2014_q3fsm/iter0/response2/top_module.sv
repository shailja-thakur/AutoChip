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

    // State encoding
    localparam A = 2'b00, B = 2'b01, B1 = 2'b10, B2 = 2'b11;

    // Sequential logic for state transitions and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            z <= 0;
        end
        else begin
            state <= next_state;
            
            // Logic for tracking w_count and cycle_count
            if (state == B || state == B1 || state == B2) begin
                if (cycle_count == 2'b10) begin
                    z <= (w_count == 2);
                    w_count <= (w == 1) ? 1 : 0;
                    cycle_count <= 0;
                end
                else begin
                    w_count <= w_count + w;
                    cycle_count <= cycle_count + 1;
                end
            end
            else begin
                z <= 0;
            end
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end
                else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = B1;
            end
            B1: begin
                next_state = B2;
            end
            B2: begin
                next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end
endmodule
